import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    if (groupA) {
      map['groupA'] = groupAHealth;
    }

    if (groupB) {
      map['groupB'] = groupBHealth;
    }

    if (map.isEmpty) {
      normalDialog(context, 'ไม่มีการเปลี่ยนแปลง');
    } else {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('Health')
            .doc(widget.idcard)
            .update(map)
            .then((value) => Navigator.pop(context));
      });
    }
  }

  Future<Null> readAlldata() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('Health')
          .doc(widget.idcard)
          .snapshots()
          .listen((event) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            diseaseHealth = event['disease'];
            foodsupplementHealth = event['foodsupplement'];
            groupAHealth = event['groupA'];
            groupBHealth = event['groupB'];
            herbHealth = event['herb'];
            medicineHealth = event['medicine'];
          });
        });
      });
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
          IconButton(onPressed: () => processEditData(), icon: Icon(Icons.edit))
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
