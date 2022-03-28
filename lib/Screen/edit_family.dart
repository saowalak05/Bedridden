import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditFamily extends StatefulWidget {
  final String idcard;
  const EditFamily({Key? key, required this.idcard});

  @override
  State<EditFamily> createState() => _EditFamilyState();
}

class _EditFamilyState extends State<EditFamily> {
  Map<String, dynamic> map = {};

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

  //Family
  String? familynameoneFamily;
  String? familynamethreeFamily;
  String? familynametwoFamily;
  String? familynamefourFamily;

  String? familyrelationshiponeFamily;
  String? familyrelationshipthreeFamily;
  String? familyrelationshiptwoFamily;
  String? familyrelationshipfourFamily;

  String? occupationoneFamily;
  String? occupationthreeFamily;
  String? occupationtwoFamily;
  String? occupationfourFamily;

  Future<Null> processEditData() async {
    if (map.isEmpty) {
      normalDialog(context, 'ไม่มีการเปลี่ยนแปลง');
    } else {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('Family')
            .doc(widget.idcard)
            .update(map)
            .then((value) => Navigator.pop(context));
      });
    }
  }

  Future<Null> readAlldata() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('Family')
          .doc('${widget.idcard}')
          .snapshots()
          .listen((event) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            familynameoneFamily = event['familynameone'];
            familynamethreeFamily = event['familynamethree'];
            familynametwoFamily = event['familynametwo'];
            familynamefourFamily = event['familynamefour'];

            familyrelationshiponeFamily = event['familyrelationshipone'];
            familyrelationshipthreeFamily = event['familyrelationshipthree'];
            familyrelationshiptwoFamily = event['familyrelationshiptwo'];
            familyrelationshipfourFamily = event['familyrelationshipfour'];

            occupationoneFamily = event['occupationone'];
            occupationtwoFamily = event['occupationtwo'];
            occupationthreeFamily = event['occupationthree'];
            occupationfourFamily = event['occupationfour'];
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
              buildtitle(),
              filedOne(),
              filedTwo(),
              filedThree(),
              filedFour(),
              buildSizeBox(),
            ]),
          ),
        ));
  }

  SizedBox buildSizeBox() {
    return SizedBox(
      height: 20,
    );
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
          onChanged: (value) {
            map['familynameone'] = value;
          },
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
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['occupationone'] = value;
          },
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
            labelText: 'อาชีพ',
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
          onChanged: (value) {
            map['familynametwo'] = value;
          },
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
            labelText: 'ชื่อ-สกุล',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['occupationtwo'] = value;
          },
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
          onChanged: (value) {
            map['familynamethree'] = value;
          },
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
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['occupationthree'] = value;
          },
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
          onChanged: (value) {
            map['familynamefour'] = value;
          },
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
            labelText: 'ชื่อ-สกุล ',
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['occupationfour'] = value;
          },
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
          ),
        ),
      ],
    );
  }
}
