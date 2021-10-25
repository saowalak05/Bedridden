import 'dart:io';
import 'dart:math';

import 'package:bedridden/models/environment_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class Addenvironment extends StatefulWidget {
  const Addenvironment({Key? key}) : super(key: key);

  @override
  _AddenvironmentState createState() => _AddenvironmentState();
}

class _AddenvironmentState extends State<Addenvironment> {
  final formkey = GlobalKey<FormState>();
  TextEditingController statusresidenceotherController =
      TextEditingController(); //'สถานะที่พักกอาศัย'
  TextEditingController housetypeotherController =
      TextEditingController(); //'ประเภทบ้าน'
  TextEditingController homeienvironmentController =
      TextEditingController(); //'สภาพสิ่งแวดล้อมในบ้าน'
  TextEditingController housingSafetyController =
      TextEditingController(); //'ความปลอยภัยภายในบ้าน'
  TextEditingController facilitiesController =
      TextEditingController(); //'สิ่งอำนวยความสะดวกภายในบ้าน'

  String? accommodation; //'ที่พัก'
  String? typeHouse; //'ประเภทบ้าน'
  String? typeHomeEnvironment; //'สภาพสิ้งแวดล้อมในบ้าน'
  String? typeHousingSafety; // 'ความปลอยภัยภายในบ้าน'
  String? typefacilities; // 'สิ่งอำนวยความสะดวกภายในบ้าน'

  String imageadd = 'assets/images/image_mountain_photo.png';

  String? typeFacilities;

  List<Widget> widgets = [];
  int accommodationgroup = 0;
  List<Widget> widgets2 = [];
  int typeHousegroup = 0;
  List<Widget> widgets3 = [];
  int homeEnvironmentgroup = 0;
  List<Widget> widgets4 = [];
  int housingSafetygroup = 0;
  List<Widget> widgets5 = [];
  int facilitiesgroup = 0;

  List<File?> files = [];
  File? fileimageenvironmement;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets.add(Text(''));
    widgets.add(Text(''));
    widgets.add(Text(''));
    widgets.add(Text(''));
    widgets.add(
      buildFormOtheraccommodation(),
    );
    widgets2.add(Text(''));
    widgets2.add(Text(''));
    widgets2.add(Text(''));
    widgets2.add(
      buildtypehouseother(),
    );
    widgets3.add(Text(''));
    widgets3.add(Text(''));
    widgets3.add(
      buildhomeEnvironmentother(),
    );
    widgets4.add(Text(''));
    widgets4.add(
      buildhousingSafetyother(),
    );
    widgets5.add(Text(''));
    widgets5.add(
      buildfacilitiesother(),
    );

    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Form(
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        buildsaveenvironment(),
                        buildTitle4(),
                        buildaccommodation(),
                        widgets[accommodationgroup],
                        buildtypeHouse(),
                        widgets2[typeHousegroup],
                        buildHomeEnvironment(),
                        widgets3[homeEnvironmentgroup],
                        buildHousingSafety(),
                        widgets4[housingSafetygroup],
                        buildFacilities(),
                        widgets5[facilitiesgroup],
                        buildImage(constraints),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.75,
                              child: MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  'เพิ่มรูปภาพ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: const Color(0xffffede5),
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                color: const Color(0xffdfad98),
                              ),
                            ),
                          ],
                        ),
                        buildNext4(context),
                      ],
                    ),
                  ),
                )));
  }

  Future<Null> proccessUploadImageenvironmentValue() async {
    String nameimage = 'environment${Random().nextInt(1000000)}.jpg';

    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('environment/$nameimage');
      UploadTask task = reference.putFile(fileimageenvironmement!);
      await task.whenComplete(() async {});
      await reference.getDownloadURL().then((value) async {
        String urlenvironmentImage = value.toString();
        print('### urlenvironmentImage ==> $urlenvironmentImage');

        EnvironmentModel model = EnvironmentModel(
            accommodation: accommodation!,
            statusresidenceother: statusresidenceotherController.text,
            typeHouse: typeHouse!,
            housetypeother: housetypeotherController.text,
            typeHomeEnvironment: typeHomeEnvironment!,
            homeienvironment: homeienvironmentController.text,
            typeHousingSafety: typeHousingSafety!,
            housingSafety: housingSafetyController.text,
            typefacilities: typefacilities!,
            facilities: facilitiesController.text,
            urlenvironmentImage: urlenvironmentImage);
      });
    });
  }

  Container buildsaveenvironment() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MaterialButton(
            onPressed: () {
              if (accommodation == null) {
                normalDialog(context, 'กรุณาเลือกสถานะของที่พักอาศัย');
              } else if (typeHouse == null) {
                normalDialog(context, 'กรุณาเลือกประเภทบ้าน');
              } else if (typeHomeEnvironment == null) {
                normalDialog(context, 'กรุณาเลือกสภาพสิ่งแวดล้อมในบ้าน');
              } else if (typeHousingSafety == null) {
                normalDialog(context, 'กรุณาเลือกความปลอดภัย');
              } else if (typeFacilities == null) {
                normalDialog(context,
                    'กรุณาเลือกมีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้');
              } else if (fileimageenvironmement == null) {
                normalDialog(context, 'กรุณาใส่รูปภาพ');
              } else if (formkey.currentState!.validate()) {
              } else {}
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

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        fileimageenvironmement = File(result!.path);
        files[index] = fileimageenvironmement;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceTmageDialog(int index) async {
    print('Click Form index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset("assets/images/bedridden.png"),
          title: Text('กรุณาเลือกแหล่งภาพ ${index + 1} ?'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processImagePicker(ImageSource.camera, index);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processImagePicker(ImageSource.gallery, index);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child: fileimageenvironmement == null
              ? Image.asset(imageadd)
              : Image.file(fileimageenvironmement!),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: constraints.maxWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(0),
                  child: files[0] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(1),
                  child: files[1] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(2),
                  child: files[2] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(3),
                  child: files[3] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildNext4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addenvironment()));
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

  Column buildFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),

        Text('มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้ :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),

        //"มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('ไม่มี'),
                value: 0,
                groupValue: facilitiesgroup,
                onChanged: (value) {
                  setState(
                    () {
                      facilitiesgroup = value as int;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text(
                'มี ได้แก่ (ราวจับในบ้าน ราวจับในห้องน้ำ ทางลาดของรถเซ็น อื่น ๆ ระบุ)'),
            value: 1,
            groupValue: facilitiesgroup,
            onChanged: (value) {
              setState(
                () {
                  facilitiesgroup = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildHousingSafety() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(' ความปลอดภัยของที่อยู่อาศัย :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('(สำรวจละเอียดโดยเฉพาะบริเวณที่ผู้ป่วยอยู่และใช้งาน)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ))
            ],
          ),
        ),

        //"ความปลอดภัยของที่อยู่อาศัย"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('ปลอดภัย'),
                value: 0,
                groupValue: housingSafetygroup,
                onChanged: (value) {
                  setState(
                    () {
                      housingSafetygroup = value as int;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ไม่ปลอดภัย อธิบายที่สังเกตได้'),
            value: 1,
            groupValue: housingSafetygroup,
            onChanged: (value) {
              setState(
                () {
                  housingSafetygroup = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildHomeEnvironment() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(' สภาพสิ่งแวดล้อมในบ้าน :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"สภาพสิ่งแวดล้อมในบ้าน"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('สะอาด'),
                value: 0,
                groupValue: homeEnvironmentgroup,
                onChanged: (value) {
                  setState(
                    () {
                      homeEnvironmentgroup = value as int;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('สะอาดปานกลาง'),
                value: 1,
                groupValue: homeEnvironmentgroup,
                onChanged: (value) {
                  setState(
                    () {
                      homeEnvironmentgroup = value as int;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ไม่สะอาด อธิบายที่สังเกตได้'),
            value: 2,
            groupValue: homeEnvironmentgroup,
            onChanged: (value) {
              setState(
                () {
                  homeEnvironmentgroup = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildtypeHouse() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('ประเภทบ้าน :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"ประเภทบ้าน"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านชั้นเดียว'),
                value: 0,
                groupValue: typeHousegroup,
                onChanged: (value) {
                  setState(
                    () {
                      typeHousegroup = value as int;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านสองชั้นขึ้นไป'),
                value: 1,
                groupValue: typeHousegroup,
                onChanged: (value) {
                  setState(
                    () {
                      typeHousegroup = value as int;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ตึกแถว ห้องแถว'),
            value: 2,
            groupValue: typeHousegroup,
            onChanged: (value) {
              setState(
                () {
                  typeHousegroup = value as int;
                },
              );
            },
          ),
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('อื่น ๆ (เช่น กระต๊อบ ชนำ เป็นต้น) ระบุ'),
            value: 3,
            groupValue: typeHousegroup,
            onChanged: (value) {
              setState(
                () {
                  typeHousegroup = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildaccommodation() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('สถานะของที่พักอาศัย :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"ที่พักอาศัย"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านพ่อแม่'),
                value: 0,
                groupValue: accommodationgroup,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationgroup = value as int;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านตนเอง'),
                value: 1,
                groupValue: accommodationgroup,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationgroup = value as int;
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
                title: const Text('บ้านญาติ'),
                value: 2,
                groupValue: accommodationgroup,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationgroup = value as int;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านเช่า'),
                value: 3,
                groupValue: accommodationgroup,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationgroup = value as int;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('อื่น ๆ'),
            value: 4,
            groupValue: accommodationgroup,
            onChanged: (value) {
              setState(
                () {
                  accommodationgroup = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildTitle4() {
    return Container(
      child: Center(
        child: Text(
          'ส่วนที่ 3 ข้อมูลสภาพแวดล้อม ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Column buildFormOtheraccommodation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                ' อื่น ๆ :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ระบุที่พักอาศัยอื่น ๆ';
            } else {
              return null;
            }
          },
          controller: statusresidenceotherController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุ',
            labelText: 'ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildtypehouseother() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'อื่น ๆ (เช่น กระต๊อบ ชนำ เป็นต้น) ระบุ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ประเภทที่พักอาศัย';
            } else {
              return null;
            }
          },
          controller: housetypeotherController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุ',
            labelText: 'ระบุ (เช่น กระต๊อบ ชนำ เป็นต้น)*',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildhomeEnvironmentother() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ไม่สะอาด อธิบายที่สังเกตได้',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ไม่สะอาด อธิบายที่สังเกตได้';
            } else {
              return null;
            }
          },
          controller: homeienvironmentController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อธิบายที่สังเกตได้',
            labelText: 'อธิบายที่สังเกตได้ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildhousingSafetyother() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ไม่ปลอดภัย อธิบายที่สังเกตได้',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ไม่ปลอดภัย อธิบายที่สังเกตได้';
            } else {
              return null;
            }
          },
          controller: housingSafetyController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อธิบายที่สังเกตได้',
            labelText: 'อธิบายที่สังเกตได้ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildfacilitiesother() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'มี ได้แก่ อะไรบ้าง',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก มีสิ่งอำนวยความสดวกให้ผู้ป่วยอะไรบ้าง';
            } else {
              return null;
            }
          },
          controller: facilitiesController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อธิบายที่สังเกตได้',
            labelText:
                'มี ได้แก่ (ราวจับในบ้าน ราวจับในห้องน้ำ ทางลาดของรถเซ็น อื่น ๆ ระบุ)*',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }
}
