import 'package:bedridden/Screen/Home/home.dart';
import 'package:bedridden/models/family_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Addfamily extends StatefulWidget {
  final String idCard;
  const Addfamily({Key? key, required this.idCard}) : super(key: key);

  @override
  _AddfamilyState createState() => _AddfamilyState();
}

class _AddfamilyState extends State<Addfamily> {
  final formkey = GlobalKey<FormState>();
  TextEditingController familynameControllerone =
      TextEditingController(); //'ชื่อ'
  TextEditingController familyrelationshipControllerone =
      TextEditingController(); //'ความสัมพันธ์'
  TextEditingController occupationContorllerone =
      TextEditingController(); //'อาชีพ'
  TextEditingController familynameControllertwo =
      TextEditingController(); //'ชื่อ'
  TextEditingController familyrelationshipControllertwo =
      TextEditingController(); //'ความสัมพันธ์'
  TextEditingController occupationContorllertwo =
      TextEditingController(); //'อาชีพ'
  TextEditingController familynameControllerthree =
      TextEditingController(); //'ชื่อ'
  TextEditingController familyrelationshipControllerthree =
      TextEditingController(); //'ความสัมพันธ์'
  TextEditingController occupationContorllerthree =
      TextEditingController(); //'อาชีพ'
  TextEditingController familynameControllerfour =
      TextEditingController(); //'ชื่อ'
  TextEditingController familyrelationshipControllerfour =
      TextEditingController(); //'ความสัมพันธ์'
  TextEditingController occupationContorllerfour =
      TextEditingController(); //'อาชีพ'

  @override
  void initState() {
    super.initState();
    print(widget.idCard);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // final IconThemeData data;
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
          'ส่วนที่ 4 ข้อมูลเครือญาติผู้ป่วย',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            children: [
              buildtitle(), //'ชื่อ-สกุล สมาชิกในครอบครัว '
              filedOne(),
              filedTwo(),
              filedThree(),
              filedFour(),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.save_alt_rounded),
        label: const Text('บันทึก'),
        backgroundColor: Color(0xfff29a94),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            proccessUplodFamily();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Future<Null> proccessUplodFamily() async {
    await Firebase.initializeApp().then((value) async {
      FamilyModel model = FamilyModel(
          familynameone: familynameControllerone.text,
          familynametwo: familynameControllertwo.text,
          familynamethree: familynameControllerthree.text,
          familynamefour: familynameControllerfour.text,
          familyrelationshipone: familyrelationshipControllerone.text,
          familyrelationshiptwo: familyrelationshipControllertwo.text,
          familyrelationshipthree: familyrelationshipControllerthree.text,
          familyrelationshipfour: familyrelationshipControllerfour.text,
          occupationone: occupationContorllerone.text,
          occupationtwo: occupationContorllertwo.text,
          occupationthree: occupationContorllerthree.text,
          occupationfour: occupationContorllerthree.text);

      await FirebaseFirestore.instance
          .collection('Family')
          .doc(
            '${widget.idCard}',
          )
          .set(model.toMap())
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())));
    });
  }

  Column buildtitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            Text(
              'ข้อมูลความสัมพันธ์กับสมาชิกในครอบครัว ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
        Row(
          children: [
            const SizedBox(height: 30.0),
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
        ),
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
                'บิดา',
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
          controller: familynameControllerone,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-สกุล',
            labelText: 'ชื่อ-สกุล',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        // TextFormField(
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
        //     } else {
        //       return null;
        //     }
        //   },
        //   controller: familyrelationshipControllerone,
        //   textCapitalization: TextCapitalization.words,
        //   decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     filled: true,
        //     hintText: 'ความสัมพันธ์กับผู้ป่วย',
        //     labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
        //     fillColor: const Color(0xfff7e4db),
        //   ),
        // ),

        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก อาชีพ';
            } else {
              return null;
            }
          },
          controller: occupationContorllerone,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ ',
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
                'มารดา',
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
          controller: familynameControllertwo,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-สกุล',
            labelText: 'ชื่อ-สกุล ',
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
          controller: occupationContorllertwo,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ',
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
                'ลูกคนที่ 1',
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
          controller: familynameControllerthree,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-สกุล',
            labelText: 'ชื่อ-สกุล',
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
          controller: occupationContorllerthree,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ',
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
                'ลูกคนที่ 2',
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
          controller: familynameControllerfour,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-สกุล',
            labelText: 'ชื่อ-สกุล',
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
          controller: occupationContorllerfour,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'อาชีพ',
            labelText: 'อาชีพ',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }
}
