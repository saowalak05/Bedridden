import 'dart:io';
import 'dart:math';
import 'package:bedridden/Screen/Addbedridden/add_family.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({
    Key? key,
  }) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

String? _typesex;
String? _typestatus;
String? typeeducationLevel;
String? typeposition;

class _AddState extends State<Add> {
  late DateTime pickedDate;
  bool bondStatus = true; // true => ยังไม่ได้เลือกวันเกิด
  bool typeeducationLevelbol = false;

  File? file;
  double? lat;
  double? lng;

  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController patientoccupationController = TextEditingController();
  TextEditingController talentController = TextEditingController();

  String? level;
  List<String> levels = ['1', '2', '3'];
  String? race;
  List<String> races = ['ไทย'];
  String? nationality;
  List<String> nationalitys = [
    'ไทย',
  ];
  String? religion;
  List<String> religions = [
    'พุทธ',
    'อิสลาม',
    'พราหมณ์-ฮินดู',
    'คริสต์',
    'ซิกข์',
  ];

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    checkPermission();
  }

  Future<Null> checkPermission() async {
    bool locationService;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLang
          findLatLng();
        }
      } else {
        if (permission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยคะ');
    }
  }

  Future<Null> findLatLng() async {
    Position? position = await findPostion();
    if (mounted) {
      setState(() {
        lat = position!.latitude;
        lng = position.longitude;
        print('lat = $lat, lng = $lng');
      });
    }
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(50.0, 50.0),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            children: [
              buildSaveBedridden(), //'บันทึก'
              Container(
                child: Center(
                  child: Text(
                    ' ส่วนที่1 ข้อมูลของผู้ป่วย ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              buildBedriddenTitle(), //'ข้อมูลผู้ป่วย'
              buildImageBedridden(context), //'รูปภาพ'
              buildNameNumBersexBedridden(), //'ชื่อ-นามสุกม,เลขบัตรประจำตัวประชาชน,เพศ'
              buildDatePickerBedridden(), //'วัน/เดือน/ปีเกิด'
              buildrace(), //'เชื้อชาติ'
              buildnationality(), //'สัญชาติ'
              buildreligion(), //'ศาสนา'
              buildTitleStatus(), //'สถานภาพสมรส'
              groupStatus(), //'ตัวเลือกสถานภาพสมรส'
              groupTypeeducation(), //'ระดับการศึกษา'
              buildAddressPhonenumberBedridden(), //'ที่อยู่เ,บอร์โทร์'
              buildMap(),
              buildOccupationTalent(), //'อาชีพ,ความสามารถพิเศษ'
              groupPosition(), //'ฐานะ'
              buildlevel(), //'ระดับกการเจ็บป่วย'
              buildNext1(context), //'หน้าถัดไป'
            ],
          ),
        ),
      ),
    );
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat, lng = $lng'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        margin: EdgeInsets.symmetric(vertical: 16),
        width: 200,
        height: 200,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Container buildSaveBedridden() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MaterialButton(
            onPressed: () {
              if (file == null) {
                normalDialog(context, 'กรุณาใส่รูปภาพ');
              } else if (_typesex == null) {
                normalDialog(context, 'กรุณาเลือก เพศ');
              } else if (bondStatus) {
                normalDialog(context, 'กรุณาเลือก วันเกิด');
              } else if (race == null) {
                normalDialog(context, 'กรุณาเลือกเชื้อชาติ');
              } else if (nationality == null) {
                normalDialog(context, 'กรุณาเลือก สัญชาติ');
              } else if (religion == null) {
                normalDialog(context, 'กรุณาเลือก ศาสนา');
              } else if (_typestatus == null) {
                normalDialog(context, 'กรุณาเลือก สถานะภาพสมรส');
              } else if (typeeducationLevel == null) {
                normalDialog(context, 'กรุณาเลือก ระดับการศึกษา');
              } else if (typeposition == null) {
                normalDialog(context, 'กรุณาเลือก ฐานะของผู้ป่วย');
              } else if (level == null) {
                normalDialog(context, 'กรุณาเลือก ระดับการป่วย');
              } else if (formkey.currentState!.validate()) {
                processUploadImageAndInsertValue();
              }
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: const Color(0xffffede5),
                ),
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              "บันทึก",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            color: const Color(0xffdfad98),
          ),
        ],
      ),
    );
  }

  Column groupPosition() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          // width: 120,
          child: Row(
            children: <Widget>[
              Text(
                'ฐานะของผู้ป่วยและครอบครัวเป็นอย่างไร :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 140,
              child: RadioListTile(
                title: const Text(
                  'ขัดสน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ขัดสน',
                groupValue: typeposition,
                onChanged: (value) {
                  setState(
                    () {
                      typeposition = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 150,
              child: RadioListTile(
                title: const Text(
                  'พออยู่พอกิน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'พออยู่พอกิน',
                groupValue: typeposition,
                onChanged: (value) {
                  setState(
                    () {
                      typeposition = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 140,
              child: RadioListTile(
                title: const Text(
                  'มีเหลือเก็บ',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'มีเหลือเก็บ',
                groupValue: typeposition,
                onChanged: (value) {
                  setState(
                    () {
                      typeposition = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildNext1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addfamily()));
          },
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xffffede5),
              ),
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            "หน้าถัดไป",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          color: const Color(0xffdfad98),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  Column buildOccupationTalent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ก่อนป่วยติดเตียงผู้ป่วยมีอาชีพอะไร';
            } else {
              return null;
            }
          },
          controller: patientoccupationController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'ก่อนป่วยติดเตียงผู้ป่วยมีอาชีพอะไร *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสามารถพิเศษ';
            } else {
              return null;
            }
          },
          controller: talentController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสามารถพิเศษ',
            labelText: 'ความสามารถพิเศษ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column groupTypeeducation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // width: 120,
          child: Row(
            children: <Widget>[
              Text(
                'ระดับการศึกษา :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ไม่ได้รับการศึกษา',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ไม่ได้รับการศึกษา',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ประถมศึกษาตอนต้น',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ประถมศึกษาตอนต้น',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ประถมศึกษาตอนปลาย',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ประถมศึกษาตอนปลาย',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'มัธยมศึกษาตอนต้น',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'มัธยมศึกษาตอนต้น',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'มัธยมศึกษาตอนปลาย',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'มัธยมศึกษาตอนปลาย',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ปวช',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปวช',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ปวส',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปวส',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'ปริญญาตรี',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปริญญาตรี',
                groupValue: typeeducationLevel,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationLevel = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildreligion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildtitlereligion(),
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              religion = value as String;
            });
          },
          value: religion,
          // hint: Text('nationality'),
          items: religions
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Container buildtitlereligion() {
    return Container(
      width: 120,
      child: Row(
        children: <Widget>[
          Text(
            'ศาสนา :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Row buildnationality() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTitlenationality(),
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              nationality = value as String;
            });
          },
          value: nationality,
          // hint: Text('nationality'),
          items: nationalitys
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Container buildTitlenationality() {
    return Container(
      width: 120,
      child: Row(
        children: <Widget>[
          Text(
            'สัญชาติ :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Row buildrace() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTitlerace(),
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              race = value as String;
            });
          },
          value: race,
          // hint: Text('เลือก'),
          items: races
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Container buildTitlerace() {
    return Container(
      width: 120,
      child: Row(
        children: <Widget>[
          Text(
            'เชื้อชาติ :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Row buildlevel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildTitleLevel(),
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              level = value as String;
            });
          },
          value: level,
          hint: Text('level :'),
          items: levels
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Column groupStatus() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('โสด'),
                value: 'โสด',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'สมรสอยู่ด้วยกัน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'สมรสอยู่ด้วยกัน',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'อยู่ด้วยกันโดยไม่จดทะเบียน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'อยู่ด้วยกันโดยไม่จดทะเบียน',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'อย่าร้าง',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'อย่าร้าง',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'หม้ายคู่สมรสเสียชีวิต',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'หม้ายคู่สมรสเสียชีวิต',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text(
                  'สมรสแยกกันอยู่',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'สมรสแยกกันอยู่',
                groupValue: _typestatus,
                onChanged: (value) {
                  setState(
                    () {
                      _typestatus = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildTitleStatus() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'สถานภาพสมรส :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Container buildTitleLevel() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'ระดับการป่วย :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Column buildDatePickerBedridden() {
    return Column(
      children: [
        ListTile(
          title: bondStatus
              ? Text("วัน/เดือน/ปีเกิด : ? , ? , ? ")
              : Text(
                  "วัน/เดือน/ปีเกิด : ${pickedDate.day} , ${pickedDate.month} , ${pickedDate.year}"),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: _pickDate,
        ),
      ],
    );
  }

  Column buildAddressPhonenumberBedridden() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ที่อยู่ปัจจุบัน';
            } else {
              return null;
            }
          },
          controller: addressController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ที่อยู่ปัจจุบัน',
            labelText: 'ที่อยู่ปัจจุบัน *',
            fillColor: const Color(0xfff7e4db),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก เบอร์โทรศัพท์';
            } else {
              if (value.length != 10) {
                return 'เบอร์โทรศัพท์ ไม่ครบ 10 หลัก';
              } else {
                return null;
              }
            }
          },
          controller: phoneController,
          maxLength: 10,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'เบอร์โทรศัพท์',
            labelText: 'เบอร์โทรศัพท์ *',
            fillColor: const Color(0xfff7e4db),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Column buildNameNumBersexBedridden() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 16.0),
        // "ชื่อ-นามสุกล" form.
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ชื่อ-นามสกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-นามสุกล',
            labelText: 'ชื่อ-นามสุกล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        // "เลขบัตรประจำตัวชาชน" form.
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก เลขบัตรประจำตัวชาชน';
            } else {
              if (value.length != 13) {
                return 'กรุณากรอกเลขบัตรประจำตัวชาชน 13 หลัก';
              } else {
                return null;
              }
            }
          },
          controller: idCardController,
          maxLength: 13,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'เลขบัตรประจำตัวชาชน',
            labelText: 'เลขบัตรประจำตัวชาชน *',
            fillColor: const Color(0xfff7e4db),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('เพศ :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"เพศ"

        Row(
          children: [
            Container(
              width: 120,
              child: RadioListTile(
                title: const Text('ชาย'),
                value: 'man',
                groupValue: _typesex,
                onChanged: (value) {
                  setState(
                    () {
                      _typesex = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 120,
              child: RadioListTile(
                title: const Text('หญิง'),
                value: 'female',
                groupValue: _typesex,
                onChanged: (value) {
                  setState(
                    () {
                      _typesex = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Widget buildImageBedridden(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => chooseImage(ImageSource.camera),
            icon: Icon(Icons.add_a_photo)),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          child: file == null ? circleAsset() : circleFile(),
        ),
        IconButton(
            onPressed: () => chooseImage(ImageSource.gallery),
            icon: Icon(Icons.add_photo_alternate)),
      ],
    );
  }

  CircleAvatar circleAsset() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: AssetImage('assets/images/account_ciecle_con.png'),
    );
  }

  CircleAvatar circleFile() {
    return CircleAvatar(
      backgroundImage: FileImage(file!),
    );
  }

  Widget buildBedriddenTitle() {
    return Container(
      child: Row(
        children: <Widget>[
          const SizedBox(height: 16.0),
          Text(
            'ข้อมูลของผู้ป่วย :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> processUploadImageAndInsertValue() async {
    String nameImage = 'sick${Random().nextInt(1000000)}.jpg';

    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('sick/$nameImage');
      UploadTask task = reference.putFile(file!);
      await task.whenComplete(() async {
        await reference.getDownloadURL().then((value) async {
          String urlImage = value.toString();
          print('## uriImage ==> $urlImage');

          Timestamp timestamp = Timestamp.fromDate(pickedDate);

          SickModel model = SickModel(
            address: addressController.text,
            bond: timestamp,
            idCard: idCardController.text,
            name: nameController.text,
            phone: phoneController.text,
            typeSex: _typesex!,
            typeStatus: _typestatus!,
            urlImage: urlImage,
            level: level!,
            nationality: nationality!,
            patientoccupation: patientoccupationController.text,
            race: race!,
            religion: religion!,
            talent: talentController.text,
            typeeducationlevel: typeeducationLevel!,
            typeposition: typeposition!,
          );

          await FirebaseFirestore.instance
              .collection('sick')
              .doc()
              .set(model.toMap())
              .then((value) =>
                  normalDialog(context, 'Insert Sick Database Success'));
        });
      });
    });
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null)
      setState(
        () {
          pickedDate = date;
          bondStatus = false;
        },
      );
  }
}
