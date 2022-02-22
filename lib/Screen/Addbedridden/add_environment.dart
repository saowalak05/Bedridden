import 'dart:io';
import 'dart:math';
import 'package:bedridden/Screen/Addbedridden/add_family.dart';
import 'package:bedridden/models/environment_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addenvironment extends StatefulWidget {
  final String idCard;
  const Addenvironment({Key? key, required this.idCard}) : super(key: key);

  @override
  _AddenvironmentState createState() => _AddenvironmentState();
}

class _AddenvironmentState extends State<Addenvironment> {
  String? accommodation; //'ที่พัก'
  String? typeHouse; //'ประเภทบ้าน'
  String? typeHomeEnvironment; //'สภาพสิ้งแวดล้อมในบ้าน'
  String? typeHousingSafety; // 'ความปลอยภัยภายในบ้าน'
  String? typefacilities; // 'สิ่งอำนวยความสะดวกภายในบ้าน'
  File? files;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffdfad98),
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(30.0, 30.0),
            ),
          ),
          title: Text(
            'ส่วนที่ 3 ข้อมูลสภาพแวดล้อม',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(top: 16, left: 8, right: 8),
              children: [
                buildaccommodation(),
                buildtypeHouse(),
                buildHomeEnvironment(),
                buildHousingSafety(),
                buildFacilities(),
                buildImage(context),
                buildsaveenvironment(),
              ],
            ),
          ),
        ));
  }

  Future<Null> proccessUploadImageenvironmentValue() async {
    String nameimage = 'environment${Random().nextInt(1000000)}.jpg';

    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('environment/$nameimage');
      UploadTask task = reference.putFile(files!);
      await task.whenComplete(() async {});
      await reference.getDownloadURL().then((value) async {
        String urlenvironmentImage = value.toString();
        print('### urlenvironmentImage ==> $urlenvironmentImage');

        EnvironmentModel model = EnvironmentModel(
            accommodation: accommodation!,
            typeHouse: typeHouse!,
            typeHomeEnvironment: typeHomeEnvironment!,
            typeHousingSafety: typeHousingSafety!,
            typefacilities: typefacilities!,
            urlenvironmentImage: urlenvironmentImage);
        await FirebaseFirestore.instance
            .collection('environment')
            .doc(
              '${widget.idCard}',
            )
            .set(model.toMap())
            .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Addfamily(
                          idCard: '${widget.idCard}',
                        ))));
      });
    });
  }

  Container buildsaveenvironment() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              } else if (typefacilities == null) {
                normalDialog(context,
                    'กรุณาเลือกมีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้');
              } else if (files == null) {
                normalDialog(context, 'กรุณาใส่รูปภาพ');
              } else {
                proccessUploadImageenvironmentValue();
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
                value: 'ไม่มี',
                groupValue: typefacilities,
                onChanged: (value) {
                  setState(
                    () {
                      typefacilities = value as String;
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
            title: const Text('มี'),
            value: 'มี',
            groupValue: typefacilities,
            onChanged: (value) {
              setState(
                () {
                  typefacilities = value as String;
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
                value: 'ปลอดภัย',
                groupValue: typeHousingSafety,
                onChanged: (value) {
                  setState(
                    () {
                      typeHousingSafety = value as String;
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
            title: const Text('ไม่ปลอดภัย'),
            value: 'ไม่ปลอดภัย',
            groupValue: typeHousingSafety,
            onChanged: (value) {
              setState(
                () {
                  typeHousingSafety = value as String;
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
                value: 'สะอาด',
                groupValue: typeHomeEnvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHomeEnvironment = value as String;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('สะอาดปานกลาง'),
                value: 'สะอาดปานกลาง',
                groupValue: typeHomeEnvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHomeEnvironment = value as String;
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
            title: const Text('ไม่สะอาด'),
            value: 'ไม่สะอาด',
            groupValue: typeHomeEnvironment,
            onChanged: (value) {
              setState(
                () {
                  typeHomeEnvironment = value as String;
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
                value: 'บ้านชั้นเดียว',
                groupValue: typeHouse,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouse = value as String;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านสองชั้นขึ้นไป'),
                value: 'บ้านสองชั้นขึ้นไป',
                groupValue: typeHouse,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouse = value as String;
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
            value: 'ตึกแถว ห้องแถว',
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String;
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
                value: 'บ้านพ่อแม่',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านตนเอง'),
                value: 'บ้านตนเอง',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String;
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
                value: 'บ้านญาติ',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านเช่า'),
                value: 'บ้านเช่า',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String;
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
            value: 'อื่น ๆ',
            groupValue: accommodation,
            onChanged: (value) {
              setState(
                () {
                  accommodation = value as String;
                },
              );
            },
          ),
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
        files = File(result!.path);
      });
    } catch (e) {}
  }

  Widget buildImage(BuildContext context) {
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
          child: files == null ? circleAsset() : circleFile(),
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
      backgroundImage: AssetImage('assets/images/image_mountain_photo.png'),
    );
  }

  CircleAvatar circleFile() {
    return CircleAvatar(
      backgroundImage: FileImage(files!),
    );
  }
}
