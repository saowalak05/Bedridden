import 'dart:ffi';

import 'package:bedridden/Screen/Addbedridden/add_health.dart';
import 'package:flutter/material.dart';

class Addfamily extends StatefulWidget {
  const Addfamily({Key? key}) : super(key: key);

  @override
  _AddfamilyState createState() => _AddfamilyState();
}

class _AddfamilyState extends State<Addfamily> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  List<Widget> widgets = [];
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgets.add(filedOne());
    widgets.add(filedTwo());
    widgets.add(filedThree());
    widgets.add(filedFour());
    widgets.add(
      filedfive(),
    );
    widgets.add(
      filedsix(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            child: ListView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              children: [
                buildTitle2(), //'ข้อมูลความสัมพันธ์กับสมาชิกในครอบครัว'
                buildtitleform(), //'ชื่อ-สกุล สมาชิกในครอบครัว '
                optionOne(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 1 คน'
                optionTwo(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 2 คน'
                optionThree(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 3 คน'
                optionFour(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 4 คน'
                optionfive(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 5 คน'
                optionsix(),//'ชื่อ-สกุล สมาชิกในครอบครัว จำนวน 6 คน'
                widgets[index],
                buildNext2(context), //'หน้าถัดไป'
              ],
            ),
          ),
        ));
  }

  Row buildtitleform() {
    return Row(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ชื่อ-สกุล สมาชิกในครอบครัว :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Column filedOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column filedTwo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 2 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '2.ชื่อ-สกุล',
            labelText: '2.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column filedThree() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 2 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '2.ชื่อ-สกุล',
            labelText: '2.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 3 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '3.ชื่อ-สกุล',
            labelText: '3.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column filedFour() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 2 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '2.ชื่อ-สกุล',
            labelText: '2.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 3 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '3.ชื่อ-สกุล',
            labelText: '3.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 4 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '4.ชื่อ-สกุล',
            labelText: '4.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column filedfive() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 2 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '2.ชื่อ-สกุล',
            labelText: '2.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 3 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '3.ชื่อ-สกุล',
            labelText: '3.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 4 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '4.ชื่อ-สกุล',
            labelText: '4.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 5 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '5.ชื่อ-สกุล',
            labelText: '5.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  Column filedsix() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 1 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '1.ชื่อ-สกุล',
            labelText: '1.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 2 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '2.ชื่อ-สกุล',
            labelText: '2.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 3 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '3.ชื่อ-สกุล',
            labelText: '3.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 4 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '4.ชื่อ-สกุล',
            labelText: '4.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 5 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '5.ชื่อ-สกุล',
            labelText: '5.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'คนที่ 6 :',
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
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: '6.ชื่อ-สกุล',
            labelText: '6.ชื่อ-สกุล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ความสัมพันธ์กับผู้ป่วย',
            labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }

  RadioListTile<int> optionsix() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 6 คน'),
      value: 5,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionfive() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 5 คน'),
      value: 4,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionFour() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 4 คน'),
      value: 3,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionThree() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 3 คน'),
      value: 2,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionTwo() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 2 คน'),
      value: 1,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  RadioListTile<int> optionOne() {
    return RadioListTile(
      title: Text('สมาชิกในครอบครัว จำนวน 1 คน'),
      value: 0,
      groupValue: index,
      onChanged: (value) {
        setState(() {
          index = value!;
        });
      },
    );
  }

  Column buildNext2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addhealth()));
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

  

  Container buildTitle2() {
    return Container(
      child: Center(
        child: Text(
          'ข้อมูลความสัมพันธ์กับสมาชิกในครอบครัว ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
