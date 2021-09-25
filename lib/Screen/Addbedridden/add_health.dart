import 'package:flutter/material.dart';

class Addhealth extends StatefulWidget {
  const Addhealth({Key? key}) : super(key: key);

  @override
  _AddhealthState createState() => _AddhealthState();
}

String? typeexamination_results;

class _AddhealthState extends State<Addhealth> {
  final formkey = GlobalKey<FormState>();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController correctController = TextEditingController();

  List<Widget> widgets = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets.add(buildcorrect());
    widgets.add(buildother1());
    widgets.add(buildincorrect());
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
                Column(
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
                        value: 0,
                        groupValue: index,
                        onChanged: (value) {
                          setState(
                            () {
                              // index = ;
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
                        value: 1,
                        groupValue: index,
                        onChanged: (value) {
                          setState(
                            () {
                              // index = value!;
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
                        value: 'อื่น ๆ ',
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
                  ],
                ),
              ],
            ),
          ),
        ));
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
