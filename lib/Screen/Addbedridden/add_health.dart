import 'package:bedridden/Screen/Addbedridden/add_environment.dart';
import 'package:bedridden/models/health_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Addhealth extends StatefulWidget {
  const Addhealth({Key? key}) : super(key: key);

  @override
  _AddhealthState createState() => _AddhealthState();
}

class _AddhealthState extends State<Addhealth> {
  final formkey = GlobalKey<FormState>();
  TextEditingController diseaseController =
      TextEditingController(); // 'โรคประจำตัว'
  TextEditingController medicineController =
      TextEditingController(); // 'ยาที่แพทย์สั่ง'
  TextEditingController inspectionresultsController =
      TextEditingController(); // 'ผลการตรวจสอบ'
  TextEditingController druguseController =
      TextEditingController(); // 'การใช้ยา'
  TextEditingController correctController =
      TextEditingController(); // 'ระบุที่ถูกต้อง'
  TextEditingController otherdrugsController =
      TextEditingController(); // 'ยาอื่นๆ'
  TextEditingController herbController = TextEditingController(); // 'สมุนไพร'
  TextEditingController foodsupplementController =
      TextEditingController(); // 'อาหารเสริมและอื่นๆ'

  // late String typeexaminationresults;
  // late String typecorrectdruguse;

  List<Widget> widgets = [];
  String? groupA  ;
  List<Widget> widgets2 = [];
  String? groupB ;

  // void _handleRadioValueChanged(value) {
  //   setState(() {
  //     groupA  = value!;
  //   });
  // }

  // void _handleRadioValueChanged2(value) {
  //   setState(() {
  //     groupB = value!;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    widgets.add(buildtext());
    widgets.add(buildincorrect());
    widgets.add(buildother1());
    widgets2.add(buildtext2());
    widgets2.add(buildcorrect());
  }

  Text buildtext2() => Text('');

  Text buildtext() => Text('');

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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              children: [
                buildsavehealth(), //'บันทึก'
                buildTitle3(), //'ส่วนที่ 2 ข้อมูลด้านสุขภาพ '
                buildDisease(), //'โรคประจำตัวหรือปัญหาสุขภาพ '
                buildmedicine(), //'ยาที่แพทย์สั่ง '
                buildtypeexaminationresults(), //'ผลการตรวจสอบ '
                // widgets[groupA as String ],
                builddruguse(), //'การใช้ยา '
                // widgets2[groupB ],
                buildOHF(), //'ยาอื่นๆ สมุนไพร อาหารเสริม '
                buildNext3(context),
              ],
            ),
          ),
        ));
  }

  Future<Null> proccessUplodhealth() async {
    await Firebase.initializeApp().then((value) 
      async {
        FirebaseStorage storage = FirebaseStorage.instance;

        HealthModel model = HealthModel(
            disease: diseaseController.text,
            medicine: medicineController.text,
            inspectionresults: inspectionresultsController.text,
            druguse: druguseController.text,
            correct: correctController.text,
            otherdrugs: otherdrugsController.text,
            herb: herbController.text,
            foodsupplement: foodsupplementController.text,
            groupA: groupA as String,
            groupB: groupB as String);

        await FirebaseFirestore.instance
            .collection('Health')
            .doc()
            .set(model.toMap())
            .then((value) => normalDialog(context, 'บันทึกข้อมูลสำเร็จ'));
    }
    );
  }

  Container buildsavehealth() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MaterialButton(
            onPressed: () {
              if (groupA == null) {
                normalDialog(context, 'กรุณาเลือก ผลการตรวจสอบ');
              } else if (groupB == null) {
                normalDialog(context, 'กรุณาเลือก การใช้ยา');
              } else {
                proccessUplodhealth();
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

  Column buildNext3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (BuildContext context) => Addenvironment(),
            );
            Navigator.push(context, route);
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

  Column buildOHF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ยาอื่น ๆ :',
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ระบุยาอื่น ๆ';
            } else {
              return null;
            }
          },
          controller: otherdrugsController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุ ยาอื่น ๆ ',
            labelText: 'ระบุ ยาอื่น ๆ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                'สมุนไพร :',
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
            filled: true,
            hintText: 'ระบุ สมุนไพร ',
            labelText: 'ระบุ สมุนไพร *',
            fillColor: const Color(0xfff7e4db),
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
            filled: true,
            hintText: 'อาหารเสริมและอื่น ๆ ',
            labelText: 'อาหารเสริมและอื่น ๆ *',
            fillColor: const Color(0xfff7e4db),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
                  groupValue: groupB,
                  selected: groupB == 0,
                  onChanged: (value) {
                    setState(() {
                      groupB = value as String;
                    });
                  }),
              RadioListTile(
                  title: const Text(
                    'ไม่ถูกต้อง',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: 'ไม่ถูกต้อง',
                  groupValue: groupB,
                  selected: groupB == 1,
                  onChanged: (value) {
                    setState(() {
                      groupB = value as String;
                    });
                  }),
            ],
          ),
        ),
      ],
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
                groupValue: groupA,
                selected: groupA == 0,
                onChanged: (value) {
                  setState(() {
                    groupA = value as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text(
                  'ไม่ตรง',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ไม่ตรง',
                groupValue: groupA,
                selected: groupA == 1,
                onChanged: (value) {
                  setState(() {
                    groupA = value as String;
                  });
                },
              ),
              RadioListTile(
                title: const Text(
                  'อื่น ๆ ',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'อื่น ๆ ',
                selected: groupA == 2,
                groupValue: groupA,
                onChanged: (value) {
                  setState(() {
                    groupA = value as String;
                  });
                },
              ),
            ],
          ),
        ),
        // Container(
        //   child: RadioListTile(
        //     title: const Text(
        //       'ไม่ตรง',
        //       style: TextStyle(fontSize: 12),
        //     ),
        //     value: 0,
        //     groupValue: _radioGroupA,
        //     selected: _radioGroupA == 0,
        //     onChanged: _handleRadioValueChanged,
        //   ),
        // ),
        // Container(
        //   child: RadioListTile(
        //     title: const Text(
        //       'อื่น ๆ ',
        //       style: TextStyle(fontSize: 12),
        //     ),
        //     value: 1,
        //     selected: _radioGroupA == 1,
        //     groupValue: _radioGroupA,
        //     onChanged: _handleRadioValueChanged,
        //   ),
        // ),
      ],
    );
  }

  Column buildmedicine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          child: buildTitlemedicine(),
        ),
        const SizedBox(
          height: 16,
        ),
        buildFormmedicine(),
      ],
    );
  }

  Text buildTitlemedicine() {
    return Text(
      'M-medication (ยาที่ใช้ประจำ) ระบุ',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  TextFormField buildFormmedicine() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอก ยาที่ใช้ประจำ';
        } else {
          return null;
        }
      },
      controller: medicineController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'ยาที่แพทย์สั่ง ได้แก่',
        labelText: 'ยาที่แพทย์สั่ง ได้แก่ *',
        fillColor: const Color(0xfff7e4db),
      ),
      maxLines: 3,
    );
  }

  Column buildDisease() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        buildCongenitalDisease(),
        const SizedBox(
          height: 10,
        ),
        buildNote(),
        const SizedBox(height: 16.0),
        buildFormdisease(),
      ],
    );
  }

  TextFormField buildFormdisease() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'กรุณากรอก โรคประจำตัวหรือปัญหาสุขภาพ';
        } else {
          return null;
        }
      },
      controller: diseaseController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        hintText: 'โรคประจำตัวหรือปัญหาสุขภาพ',
        labelText: 'โรคประจำตัวหรือปัญหาสุขภาพ *',
        fillColor: const Color(0xfff7e4db),
      ),
    );
  }

  Text buildCongenitalDisease() {
    return Text(
      'ท่านมีโรคประจำตัวหรือปัญหาสุขภาพหรือไม่ :',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text buildNote() {
    return Text(
      'หมายเหตุ : ถามการรับรู้ของผู้ป่วย/ผู้ดูแล จำเป็นต้องตรวจสอบกับเวชระเบียนผู้ป่วย (Review medical record) ',
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Container buildTitle3() {
    return Container(
      child: Center(
        child: Text(
          'ส่วนที่ 2 ข้อมูลด้านสุขภาพ ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Column buildcorrect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                ' ระบุที่ถูกต้อง :',
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
              return 'กรุณากรอก ผลการตรวจสอบที่ถูกต้อง';
            } else {
              return null;
            }
          },
          controller: correctController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุที่ถูกต้อง',
            labelText: 'ระบุที่ถูกต้อง *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildincorrect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ไม่ถูกต้องอย่างไร :',
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
              return 'กรุณากรอก การใช้ยา ไม่ถูกต้องอย่างไร';
            } else {
              return null;
            }
          },
          controller: druguseController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ไม่ถูกต้องอย่างไร ',
            labelText: 'ไม่ถูกต้องอย่างไร *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column buildother1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'อื่น ๆ :',
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
              return 'กรุณากรอก ผลการตรวจสอบอื่น ๆ';
            } else {
              return null;
            }
          },
          controller: inspectionresultsController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุ ',
            labelText: 'ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }
}
