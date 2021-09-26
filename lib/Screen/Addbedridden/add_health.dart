import 'package:bedridden/Screen/Addbedridden/add_environment.dart';
import 'package:flutter/material.dart';

class Addhealth extends StatefulWidget {
  const Addhealth({Key? key}) : super(key: key);

  @override
  _AddhealthState createState() => _AddhealthState();
}


class _AddhealthState extends State<Addhealth> {
  final formkey = GlobalKey<FormState>();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController correctController = TextEditingController();
  TextEditingController other_drugsController = TextEditingController();
  TextEditingController HerbController = TextEditingController();

String? typeexamination_results;
String? typecorrect_drug_use;


  List<Widget> widgets = [];
  int index = 0;
  List<Widget> widgets2 = [];
  int index2 = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets.add(buildincorrect());
    widgets.add(buildother1());
    widgets2.add(buildcorrect());
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              children: [
                buildTitle3(), //'ส่วนที่ 2 ข้อมูลด้านสุขภาพ '
                buildDisease(), //'โรคประจำตัวหรือปัญหาสุขภาพ '
                buildmedicine(), //'ยาที่แพทย์สั่ง '
                buildtypeexamination_results(), //'ผลการตรวจสอบ '
                widgets[index],
                builddrug_use(), //'การใช้ยา '
                widgets2[index],
                buildOHF(), //'ยาอื่นๆ สมุนไพร อาหารเสริม '
                buildNext3(context),
              ],
            ),
          ),
        ));
  }

  Column buildNext3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addenvironment()));
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
          controller: other_drugsController,
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
          controller: HerbController,
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
          controller: HerbController,
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

  Column builddrug_use() {
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
          child: RadioListTile(
            title: const Text(
              'ถูกต้อง',
              style: TextStyle(fontSize: 12),
            ),
            value: 'ถูกต้อง',
            groupValue: typecorrect_drug_use,
            onChanged: (value) {
              setState(
                () {
                  typecorrect_drug_use = value as String;
                },
              );
            },
          ),
        ),
        Container(
          child: RadioListTile(
            title: const Text(
              'ไม่ถูกต้อง',
              style: TextStyle(fontSize: 12),
            ),
            value: 0,
            groupValue: index2,
            onChanged: (value) {
              setState(
                () {
                  index2 = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildtypeexamination_results() {
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
          child: RadioListTile(
            title: const Text(
              'ตรงกับการรับรู้ของผู้ป่วย/ผู้ดูแล',
              style: TextStyle(fontSize: 12),
            ),
            value: 'ตรงกับการรับรู้ของผู้ป่วย/ผู้ดูแล',
            groupValue: typeexamination_results,
            onChanged: (value) {
              setState(
                () {
                  typeexamination_results = value as String?;
                },
              );
            },
          ),
        ),
        Container(
          child: RadioListTile(
            title: const Text(
              'ไม่ตรง',
              style: TextStyle(fontSize: 12),
            ),
            value: 0,
            groupValue: index,
            onChanged: (value) {
              setState(
                () {
                  index = value as int;
                },
              );
            },
          ),
        ),
        Container(
          child: RadioListTile(
            title: const Text(
              'อื่น ๆ ',
              style: TextStyle(fontSize: 12),
            ),
            value: 1,
            groupValue: index,
            onChanged: (value) {
              setState(
                () {
                  index = value as int;
                },
              );
            },
          ),
        ),
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
          controller: correctController,
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
          controller: correctController,
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
