import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class EditHealth extends StatefulWidget {
  final String idcard;
  const EditHealth({Key? key, required this.idcard});

  @override
  _EditHealthState createState() => _EditHealthState();
}

class _EditHealthState extends State<EditHealth> {
  Map<String, dynamic> map = {};

  //Health
  String? diseaseHealth;
  String? foodsupplementHealth;
  String? groupAHealth;
  String? groupBHealth;
  String? herbHealth;
  String? medicineHealth;

  bool groupA = true;
  bool groupB = true;

  final formkey = GlobalKey<FormState>();
  TextEditingController diseaseController =
      TextEditingController(); // 'โรคประจำตัว'
  TextEditingController medicineController =
      TextEditingController(); // 'ยาที่แพทย์สั่ง'
  TextEditingController herbController = TextEditingController(); // 'สมุนไพร'
  TextEditingController foodsupplementController =
      TextEditingController(); // 'อาหารเสริมและอื่นๆ'

  Future<Null> processEditData() async {
    map['disease'] = diseaseController.text;
    map['foodsupplement'] = foodsupplementController.text;
    map['medicine'] = medicineController.text;
    map['herb'] = herbController.text;
    map['groupA'] = groupAHealth;
    map['groupB'] = groupBHealth;

    // save sub collection
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    // add field timestamp to your map data
    map['timestamp'] = timeStamp;

    await Firebase.initializeApp().then((value) async {
      // add to log data
      saveData(map: map, timeStamp: timeStamp);
    });
  }

  // save data to firestore
  saveData(
      {required Map<String, dynamic> map, required String timeStamp}) async {
    await Firebase.initializeApp().then((value) async {
      // add to log data
      await FirebaseFirestore.instance
          .collection('Health')
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
          .collection('Health')
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
            .collection('Health')
            .doc(widget.idcard)
            .get()
            .then((DocumentSnapshot event) {
          // TODO : set data
          // set screen state
          setState(() {
            // set default data in some field

            diseaseHealth = event['disease'];
            foodsupplementHealth = event['foodsupplement'];
            groupAHealth = event['groupA'];
            groupBHealth = event['groupB'];
            herbHealth = event['herb'];
            medicineHealth = event['medicine'];

            // set data to text controller field
            diseaseController.text = event["disease"];
            medicineController.text = event["medicine"];
            herbController.text = event["herb"];
            foodsupplementController.text = event["foodsupplement"];
          });
        });
      } else {
        // has log data
        QueryDocumentSnapshot event = lastLog.docs.first;
        // TODO : set data
        // set screen state
        setState(() {
          // set default data in some field
          diseaseHealth = event['disease'];
          foodsupplementHealth = event['foodsupplement'];
          groupAHealth = event['groupA'];
          groupBHealth = event['groupB'];
          herbHealth = event['herb'];
          medicineHealth = event['medicine'];

          // set data to text controller field
          diseaseController.text = event["disease"];
          medicineController.text = event["medicine"];
          herbController.text = event["herb"];
          foodsupplementController.text = event["foodsupplement"];
        });
      }
    });
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
          child: Column(children: [
            titledisease(),
            buildSizeBox(),
            fieldAddress(),
            buildSizeBox(),
            titlemedicine(),
            buildSizeBox(),
            fielmedicine(),
            buildSizeBox(),
            buildtypeexaminationresults(),
            builddruguse(),
            buildOHF(),
            buildSizeBox(),
            buildSizeBox(),
          ]),
        ),
      ),
    );
  }

  SizedBox buildSizeBox() {
    return SizedBox(
      height: 16,
    );
  }

  Row titledisease() {
    return Row(
      children: [
        Text('โรคประจำตัวหรือปัญหาสุขภาพ :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  TextFormField fieldAddress() {
    return TextFormField(
      onChanged: (value) {
        map['disease'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'disease Not Empty';
        } else {
          return null;
        }
      },
      controller: diseaseController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  Row titlemedicine() {
    return Row(
      children: [
        Text('M-medication (ยาที่ใช้ประจำ) :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  TextFormField fielmedicine() {
    return TextFormField(
      onChanged: (value) {
        map['medicine'] = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'medicine Not Empty';
        } else {
          return null;
        }
      },
      controller: medicineController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  Column buildtypeexaminationresults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ผลการตรวจสอบ :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              RadioListTile(
                title: const Text(
                  'ตรงกับการรับรู้ของผู้ป่วย/ผู้ดูแล',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ตรงกับการรับรู้ของผู้ป่วย/ผู้ดูแล',
                groupValue: groupAHealth,
                onChanged: (value) {
                  setState(() {
                    groupAHealth = value as String;
                    groupA = true;
                  });
                },
              ),
              RadioListTile(
                title: const Text(
                  'ไม่ตรง',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ไม่ตรง',
                groupValue: groupAHealth,
                onChanged: (value) {
                  setState(() {
                    groupAHealth = value as String;
                    groupA = true;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column builddruguse() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'การใช้ยา :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              RadioListTile(
                  title: const Text(
                    'ถูกต้อง',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: 'ถูกต้อง',
                  groupValue: groupBHealth,
                  onChanged: (value) {
                    setState(() {
                      groupBHealth = value as String;
                      groupB = true;
                    });
                  }),
              RadioListTile(
                  title: const Text(
                    'ไม่ถูกต้อง',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: 'ไม่ถูกต้อง',
                  groupValue: groupBHealth,
                  onChanged: (value) {
                    setState(() {
                      groupBHealth = value as String;
                      groupB = true;
                    });
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Column buildOHF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'สมุนไพร :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['herb'] = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ระบุสมุนไพร';
            } else {
              return null;
            }
          },
          controller: herbController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'อาหารเสริมและอื่น ๆ :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['foodsupplement'] = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาหารเสริมและอื่น ๆ';
            } else {
              return null;
            }
          },
          controller: foodsupplementController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
