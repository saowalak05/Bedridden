import 'package:bedridden/utility/dialog.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditSick extends StatefulWidget {
  final String idcard;
  const EditSick({Key? key, required this.idcard}) : super(key: key);

  @override
  _EditSickState createState() => _EditSickState();
}

class _EditSickState extends State<EditSick> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idcardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController patientoccupationController = TextEditingController();
  TextEditingController talentController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool load = true;
  String? email;
  bool changeDisplayName = true; // true => ยังไม่มีการเปลี่ยน DisplayName
  String? urlImageSick;
  File? file;
  Map<String, dynamic> map = {};

  late DateTime pickedDate;
  bool bondStatus = false; // true => ยังไม่ได้เลือกวันเกิด

  bool typeSexBol = true;
  bool typeStatusBol = false;
  bool bondDateTimebol = false;
  bool bondDateTimeStrbol = false;
  bool typeducationlevel = true;
  bool typeposition = true;
  bool typereligions = true;
  bool typelevel = true;
  bool statusImage = false;

  double? lat;
  double? lng;

  List<String> races = ['ไทย'];
  List<String> nationalitys = ['ไทย'];
  List<String> religions = [
    'พุทธ',
    'อิสลาม',
    'พราหมณ์-ฮินดู',
    'คริสต์',
    'ซิกข์',
  ];
  List<String> levels = ['1', '2', '3'];

//sick
  String? addressSick;
  String? bondSick;
  String? idCardSick;
  String? latSick;
  String? levelSick;
  String? lngSick;
  String? nameSick;
  String? nationalitySick;
  String? patientoccupationSick;
  String? phoneSick;
  String? raceSick;
  String? religionSick;
  String? talentSick;
  String? typeSexSick;
  String? typeStatusSick;
  String? typeeducationlevelSick;
  String? typepositionSick;

  @override
  void initState() {
    super.initState();
    print(widget.idcard);
    readAlldata();
    pickedDate = DateTime.now();
    checkPermission();
    findCurrentUser();
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
  }

  Future<Null> readAlldata() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('sick')
          .doc(widget.idcard)
          .snapshots()
          .listen((event) {
        DateTime dateTime = event['bond'].toDate();
        DateFormat dateFormat = DateFormat('dd-MMMM-yyyy', 'th');
        String bondStr = dateFormat.format(dateTime);
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            addressSick = event['address'];
            bondSick = bondStr;
            idCardSick = event['idCard'];
            latSick = event['lat'].toString();
            lngSick = event['lng'].toString();
            levelSick = event['level'];
            nameSick = event['name'];
            nationalitySick = event['nationality'];
            patientoccupationSick = event['patientoccupation'];
            phoneSick = event['phone'];
            raceSick = event['race'];
            religionSick = event['religion'];
            talentSick = event['talent'];
            typeSexSick = event['typeSex'];
            typeStatusSick = event['typeStatus'];
            typeeducationlevelSick = event['typeeducation_level'].toString();
            typepositionSick = event['typeposition'].toString();
            urlImageSick = event['urlImage'];
          });
        });
      });
    });
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

  Future<Null> confirmImageDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          title: Text('กรุณาเลือกแหล่งภาพ'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processGetImage(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processGetImage(ImageSource.gallery);
            },
            child: Text('Gallery'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<Null> findCurrentUser() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          userNameController.text = event!.displayName!;
          email = event.email;
          urlImageSick = event.photoURL;
          print('### urlImage = $urlImageSick');
          load = false;
        });
      });
    });
  }

  Padding buildUpdateImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 260, left: 4),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (file == null) {
              normalDialog(context, 'กรุณาใส่ภาพ');
            } else {
              processChangeImageProfile();
            }
          },
        ),
      ),
    );
  }

  Future<Null> processChangeImageProfile() async {
    String urlImage = 'sick${Random().nextInt(100000)}.jpg';
    print('## nameImage ==>> $urlImage');
    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('sick/$urlImage');
      UploadTask task = reference.putFile(file!);
      await task.whenComplete(() async {
        await reference.getDownloadURL().then((value) async {
          print('Upload Success access Token ==> $value');
          String urlImage = value.toString();
          FirebaseAuth.instance.authStateChanges().listen((event) async {
            await event!.updatePhotoURL(urlImage).then((value) =>
                normalDialog(context, 'Update Image Profile Success'));
          });
        });
      });
    });
  }

  Future<Null> processChangeDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) async {
        await event!
            .updateDisplayName(userNameController.text)
            .then((value) => normalDialog(context, 'change Dsiplay Success'));
      });
    });
  } // end

  Future<Null> processGetImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
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

  CircleAvatar circleFile() {
    return CircleAvatar(
      backgroundImage: FileImage(file!),
    );
  }

  CircleAvatar circleNetwork() {
    return CircleAvatar(
      backgroundImage: NetworkImage(urlImageSick!),
    );
  }

  // CircleAvatar circleAsset() {
  //   return CircleAvatar(
  //     backgroundColor: Colors.white,
  //     backgroundImage: AssetImage(
  //       '$urlImageSick',
  //     ),
  //   );
  // }
  Container circleAsset() {
    return Container(
      width: 200,
      child: Image.network(
        '$urlImageSick',
        errorBuilder: (context, exception, stackTrack) => Icon(Icons.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'แก้ไขข้อมูล',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(30.0, 30.0),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => processEditData(),
              icon: Icon(Icons.save_as_rounded))
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 8),
            child: Column(
              children: [
                titleImage(),
                buildSizeBox(),
                buildImage(),
                buildSizeBox(),
                controllerImage(),
                buildSizeBox(),
                titleName(),
                buildSizeBox(),
                fieldName(),
                buildSizeBox(),
                titleidcard(),
                buildSizeBox(),
                fieldidcard(),
                buildSizeBox(),
                titleAddress(),
                buildSizeBox(),
                fieldAddress(),
                buildSizeBox(),
                titlePhone(),
                buildSizeBox(),
                fieldPhone(),
                buildSizeBox(),
                titlebond(),
                buildSizeBox(),
                buildBond(),
                titleGendle(),
                radioGendle(),
                groupStatus(),
                buildSizeBox(),
                groupTypeeducation(),
                buildSizeBox(),
                titlepatientoccupation(),
                buildSizeBox(),
                fieldpatientoccupation(),
                buildSizeBox(),
                titletalent(),
                buildSizeBox(),
                fieldtalent(),
                buildSizeBox(),
                groupPosition(),
                buildSizeBox(),
                buildrace(),
                buildnationality(),
                buildreligion(),
                buildlevel(),
                buildMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildBond() {
    return ListTile(
      title: bondStatus
          ? Text('$bondSick')
          : Text(
              "วัน/เดือน/ปีเกิด : ${pickedDate.day} , ${pickedDate.month} , ${pickedDate.year}"),
      trailing: Icon(Icons.keyboard_arrow_down),
      onTap: _pickDate,
    );
  }

  Future<Null> processEditData() async {
    if (changeDisplayName) {
      processChangeDisplayName();
    }

    if (typeSexBol) {
      map['typeSex'] = typeSexSick;
    }

    if (typeStatusBol) {
      map['typeStatus'] = typeStatusSick;
    }

    if (typeducationlevel) {
      map['typeeducation_level'] = typeeducationlevelSick;
    }

    if (typeposition) {
      map['typeposition'] = typepositionSick;
    }

    if (typereligions) {
      map['religion'] = religionSick;
    }

    if (typelevel) {
      map['level'] = levelSick;
    }

    map['bond'] = pickedDate;
    map['lat'] = lat;
    map['lng'] = lng;

    print('### map ==>> $map');
    if (map.isEmpty) {
      normalDialog(context, 'ไม่มีการเปลี่ยนแปลง');
    } else {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('sick')
            .doc(widget.idcard)
            .update(map)
            .then((value) => Navigator.pop(context));
      });
    }
  }

  Set<Marker> setMarker() => <Marker>{
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'พิกัด ' + '$nameSick', snippet: 'Lat = $lat, lng = $lng'),
        ),
      }.toSet();

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
                onTap: (latLng) {
                  setState(() {
                    lat = latLng.latitude;
                    lng = latLng.longitude;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

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

  Row buildlevel() {
    return Row(
      children: [
        buildTitleLevel(),
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              levelSick = value as String;
              typelevel = true;
            });
          },
          value: levelSick,
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

  Container buildTitleLevel() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'ระดับการป่วย :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
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
              religionSick = value as String;
              typereligions = true;
            });
          },
          value: religionSick,
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
              nationalitySick = value as String;
            });
          },
          value: nationalitySick,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
              raceSick = value as String;
            });
          },
          value: raceSick,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
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
                  fontSize: 16,
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
                groupValue: typepositionSick,
                onChanged: (value) {
                  setState(
                    () {
                      typepositionSick = value as String?;
                      typeposition = true;
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
                groupValue: typepositionSick,
                onChanged: (value) {
                  setState(
                    () {
                      typepositionSick = value as String?;
                      typeposition = true;
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
                groupValue: typepositionSick,
                onChanged: (value) {
                  setState(
                    () {
                      typepositionSick = value as String?;
                      typeposition = true;
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

  Column groupTypeeducation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ระดับการศึกษา :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ไม่ได้รับการศึกษา',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ไม่ได้รับการศึกษา',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ประถมศึกษาตอนต้น',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ประถมศึกษาตอนต้น',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
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
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ประถมศึกษาตอนปลาย',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ประถมศึกษาตอนปลาย',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'มัธยมศึกษาตอนต้น',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'มัธยมศึกษาตอนต้น',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
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
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'มัธยมศึกษาตอนปลาย',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'มัธยมศึกษาตอนปลาย',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ปวช',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปวช',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
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
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ปวส',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปวส',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ปริญญาตรี',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ปริญญาตรี',
                groupValue: typeeducationlevelSick,
                onChanged: (value) {
                  setState(
                    () {
                      typeeducationlevelSick = value as String?;
                      typeducationlevel = true;
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

  Column groupStatus() {
    return Column(
      children: [
        Row(
          children: [
            Text('สถานภาพ :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        RadioListTile(
          title: const Text('โสด'),
          value: 'โสด',
          groupValue: typeStatusSick,
          onChanged: (value) {
            setState(
              () {
                typeStatusSick = value as String?;
                typeStatusBol = true;
              },
            );
          },
        ),
        RadioListTile(
          title: const Text('สมรส'),
          value: 'สมรส',
          groupValue: typeStatusSick,
          onChanged: (value) {
            setState(
              () {
                typeStatusSick = value as String?;
                typeStatusBol = true;
              },
            );
          },
        ),
        RadioListTile(
          title: const Text('หม้าย'),
          value: 'หม้าย',
          groupValue: typeStatusSick,
          onChanged: (value) {
            setState(
              () {
                typeStatusSick = value as String?;
                typeStatusBol = true;
              },
            );
          },
        ),
        RadioListTile(
          title: const Text('อย่าร้าง'),
          value: 'อย่าร้าง',
          groupValue: typeStatusSick,
          onChanged: (value) {
            setState(
              () {
                typeStatusSick = value as String?;
                typeStatusBol = true;
              },
            );
          },
        ),
      ],
    );
  }

  Row radioGendle() {
    return Row(
      children: [
        Container(
          width: 120,
          child: RadioListTile(
            title: Text('ชาย'),
            value: 'ชาย',
            groupValue: typeSexSick,
            onChanged: (value) {
              setState(() {
                typeSexSick = value as String?;
                typeSexBol = true;
              });
            },
          ),
        ),
        Container(
          width: 120,
          child: RadioListTile(
            title: Text('หญิง'),
            value: 'หญิง',
            groupValue: typeSexSick,
            onChanged: (value) {
              setState(() {
                typeSexSick = value as String?;
                typeSexBol = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Row titleGendle() {
    return Row(
      children: [
        Text('เพศ :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titleImage() {
    return Row(
      children: [
        Text('รูปภาพผู้ป่วย :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row controllerImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => confirmImageDialog(),
            icon: Icon(Icons.add_photo_alternate)),
      ],
    );
  }

  Container buildImage() {
    return Container(
      // width: 200,
      // child: Image.network(
      //   '$urlImageSick',
      //   errorBuilder: (context, exception, stackTrack) => Icon(Icons.error),
      // ),

      // padding: EdgeInsets.all(50.0),
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.width / 2.5,
      child: file != null
          ? circleFile()
          : urlImageSick != null
              ? circleNetwork()
              : circleAsset(),
    );
  }

  SizedBox buildSizeBox() {
    return SizedBox(
      height: 16,
    );
  }

  Row titlebond() {
    return Row(
      children: [
        Text('วัน/เดือน/ปีเกิด :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titlepatientoccupation() {
    return Row(
      children: [
        Text('ก่อนป่วยติดเตียงผู้ป่วยมีอาชีพอะไร :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titleName() {
    return Row(
      children: [
        Text('ชื่อ-นามสกุล :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titleidcard() {
    return Row(
      children: [
        Text('เลขบัตรประจำตัวประชาชน :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titleAddress() {
    return Row(
      children: [
        Text('ที่อยู่ปัจจุบัน :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titlePhone() {
    return Row(
      children: [
        Text('ที่อยู่ปัจจุบัน :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row titletalent() {
    return Row(
      children: [
        Text('ความสามารถพิเศษ :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  TextFormField fieldtalent() {
    return TextFormField(
      onChanged: (value) {
        map['talent'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'talent Not Empty';
        } else {
          return null;
        }
      },
      controller: talentController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextFormField fieldpatientoccupation() {
    return TextFormField(
      onChanged: (value) {
        map['patientoccupation'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Patientoccupation Not Empty';
        } else {
          return null;
        }
      },
      controller: patientoccupationController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextFormField fieldName() {
    return TextFormField(
      onChanged: (value) {
        map['name'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name Not Empty';
        } else {
          return null;
        }
      },
      controller: nameController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextFormField fieldidcard() {
    return TextFormField(
      onChanged: (value) {
        map['idCard'] = value;
      },
      maxLength: 13,
      validator: (value) {
        if (value!.isEmpty) {
          return 'IdCard Not Empty';
        } else {
          return null;
        }
      },
      controller: idcardController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextFormField fieldAddress() {
    return TextFormField(
      onChanged: (value) {
        map['address'] = value;
      },
      maxLines: 3,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Address Not Empty';
        } else {
          return null;
        }
      },
      controller: addressController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  TextFormField fieldPhone() {
    return TextFormField(
      onChanged: (value) {
        map['phone'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phone Not Empty';
        } else {
          return null;
        }
      },
      controller: phoneController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }
}
