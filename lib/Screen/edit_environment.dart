import 'dart:io';
import 'dart:math';
import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;

class EditEnvironment extends StatefulWidget {
  final String idcard;
  const EditEnvironment({Key? key, required this.idcard});

  @override
  _EditEnvironmentState createState() => _EditEnvironmentState();
}

class _EditEnvironmentState extends State<EditEnvironment> {
  Map<String, dynamic> map = {};

  // environment
  String? accommodationenvironment;
  String? typeHomeEnvironmentenvironment;
  String? typeHouseenvironment;
  String? typeHousingSafetyenvironment;
  String? typefacilitiesenvironment;
  String? urlenvironmentImageenvironment;

  File? files;

  bool typeHouse = true;
  bool typeHomeEnvironment = true;
  bool typeHousingSafety = true;
  bool typefacilities = true;
  bool typeaccommodation = true;
  bool statusImage = false;

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

  Future<Null> processEditData() async {
    // prepare data to your map so this should change to model
    // var data = {
    //   'name': nameController.text,
    //    ...
    // }
    map['typeHouse'] = typeHouseenvironment;
    map['typeHomeEnvironment'] = typeHomeEnvironmentenvironment;
    map['typeHousingSafety'] = typeHousingSafetyenvironment;
    map['typefacilities'] = typefacilitiesenvironment;
    map['accommodation'] = accommodationenvironment;
    map['urlenvironmentImage'] = urlenvironmentImageenvironment;

    // save sub collection
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    // add field timestamp to your map data
    map['timestamp'] = timeStamp;

    if (files == null) {
      dev.log("file is null so, don't upload image just save data only");

      dev.log('### map ==>> $map');

      // save data to firestore
      await Firebase.initializeApp().then((value) async {
        // add to log data
        saveData(map: map, timeStamp: timeStamp);
      });
    } else {
      dev.log("file is not null so, upload image and save data");
      // upload file then add data to firesore
      String environmentImage = 'environment${Random().nextInt(1000000)}.jpg';
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference =
          storage.ref().child('environment/$environmentImage');
      UploadTask task = reference.putFile(files!);
      await task.whenComplete(() async {
        await reference.getDownloadURL().then((value) async {
          String urlImage = value.toString();

          // set map data with new url image
          if (files != null) {
            map['urlImage'] = urlImage;
          }

          dev.log('### map ==>> $map');
          // add to log data
          saveData(map: map, timeStamp: timeStamp);
        });
      });
    }
  }

  // save data to firestore
  saveData(
      {required Map<String, dynamic> map, required String timeStamp}) async {
    await Firebase.initializeApp().then((value) async {
      // add to log data
      await FirebaseFirestore.instance
          .collection('environment')
          .doc(widget.idcard)
          .collection('logs')
          .doc(timeStamp)
          .set(map)
          .then((value) => Navigator.pop(context));
    });
  }

  Future<Null> readAlldata() async {
    // init firebase
    await Firebase.initializeApp().then((value) async {
      // TODO : let's check log exist ?
      QuerySnapshot lastLog = await FirebaseFirestore.instance
          .collection('environment')
          .doc(widget.idcard)
          .collection('logs')
          .orderBy('timestamp', descending: true)
          .get();
      dev.log('found log data = ${lastLog.docs.length} items');

      if (lastLog.docs.length == 0) {
        dev.log("read master data");
        // read master data
        dev.log('read from docId - ${widget.idcard}');
        FirebaseFirestore.instance
            .collection('environment')
            .doc(widget.idcard)
            .get()
            .then((DocumentSnapshot event) {
          dev.log('read master data');

          // TODO : set data
          // set screen state
          setState(() {
            // set default data in some field
            accommodationenvironment = event['accommodation'];
            typeHomeEnvironmentenvironment = event['typeHomeEnvironment'];
            typeHouseenvironment = event['typeHouse'];
            typeHousingSafetyenvironment = event['typeHousingSafety'];
            typefacilitiesenvironment = event['typefacilities'];
            urlenvironmentImageenvironment = event['urlenvironmentImage'];
          });
        });
      } else {
        // has log data
        QueryDocumentSnapshot event = lastLog.docs.first;

        // TODO : set data
        // set screen state
        setState(() {
          // set default data in some field
          accommodationenvironment = event['accommodation'];
          typeHomeEnvironmentenvironment = event['typeHomeEnvironment'];
          typeHouseenvironment = event['typeHouse'];
          typeHousingSafetyenvironment = event['typeHousingSafety'];
          typefacilitiesenvironment = event['typefacilities'];
          urlenvironmentImageenvironment = event['urlenvironmentImage'];
        });
      }
    });
  }

  Future<Null> processGetImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        files = File(result!.path);
        statusImage = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    print(widget.idcard);
    readAlldata();
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
        body: Container(
          margin: EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(
                children: [
                  buildaccommodation(),
                  buildtypeHouse(),
                  buildHomeEnvironment(),
                  buildHousingSafety(),
                  buildFacilities(),
                  buildSizeBox(),
                  titleImage(),
                  buildSizeBox(),
                  buildImage(),
                  buildSizeBox(),
                  controllerImage(),
                ],
              )),
        ));
  }

  SizedBox buildSizeBox() {
    return SizedBox(
      height: 16,
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
        width: 200,
        child: files == null
            ? Image.network(
                '$urlenvironmentImageenvironment',
                errorBuilder: (context, exception, stackTrack) =>
                    Icon(Icons.error),
              )
            : Image.file(files!));
  }

  Column buildFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),

        Text('มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้ :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),

        //"มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('ไม่มี'),
                value: 'ไม่มี',
                groupValue: typefacilitiesenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typefacilitiesenvironment = value as String;
                      typefacilities = true;
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
            groupValue: typefacilitiesenvironment,
            onChanged: (value) {
              setState(
                () {
                  typefacilitiesenvironment = value as String;
                  typefacilities = true;
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                groupValue: typeHousingSafetyenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHousingSafetyenvironment = value as String;
                      typeHousingSafety = true;
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
            groupValue: typeHousingSafetyenvironment,
            onChanged: (value) {
              setState(
                () {
                  typeHousingSafetyenvironment = value as String;
                  typeHousingSafety = true;
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),

        //"สภาพสิ่งแวดล้อมในบ้าน"

        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('สะอาด'),
                value: 'สะอาด',
                groupValue: typeHomeEnvironmentenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHomeEnvironmentenvironment = value as String;
                      typeHomeEnvironment = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('สะอาดปานกลาง'),
                value: 'สะอาดปานกลาง',
                groupValue: typeHomeEnvironmentenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHomeEnvironmentenvironment = value as String;
                      typeHomeEnvironment = true;
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
            groupValue: typeHomeEnvironmentenvironment,
            onChanged: (value) {
              setState(
                () {
                  typeHomeEnvironmentenvironment = value as String;
                  typeHomeEnvironment = true;
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),

        //"ประเภทบ้าน"

        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('บ้านชั้นเดียว'),
                value: 'บ้านชั้นเดียว',
                groupValue: typeHouseenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouseenvironment = value as String;
                      typeHouse = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('บ้านสองชั้นขึ้นไป'),
                value: 'บ้านสองชั้นขึ้นไป',
                groupValue: typeHouseenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouseenvironment = value as String;
                      typeHouse = true;
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
            groupValue: typeHouseenvironment,
            onChanged: (value) {
              setState(
                () {
                  typeHouseenvironment = value as String;
                  typeHouse = true;
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),

        //"ที่พักอาศัย"

        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('บ้านพ่อแม่'),
                value: 'บ้านพ่อแม่',
                groupValue: accommodationenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationenvironment = value as String;
                      typeaccommodation = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('บ้านตนเอง'),
                value: 'บ้านตนเอง',
                groupValue: accommodationenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationenvironment = value as String;
                      typeaccommodation = true;
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
                title: const Text('บ้านญาติ'),
                value: 'บ้านญาติ',
                groupValue: accommodationenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationenvironment = value as String;
                      typeaccommodation = true;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text('บ้านเช่า'),
                value: 'บ้านเช่า',
                groupValue: accommodationenvironment,
                onChanged: (value) {
                  setState(
                    () {
                      accommodationenvironment = value as String;
                      typeaccommodation = true;
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
            groupValue: accommodationenvironment,
            onChanged: (value) {
              setState(
                () {
                  accommodationenvironment = value as String;
                  typeaccommodation = true;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
