import 'package:bedridden/models/curator_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditCurator extends StatefulWidget {
  final String idcard;
  const EditCurator({Key? key, required this.idcard});
  @override
  State<EditCurator> createState() => _EditCuratorState();
}

class _EditCuratorState extends State<EditCurator> {
  Map<String, dynamic> map = {};

  final formkey = GlobalKey<FormState>();
  TextEditingController curatornameControllerone =
      TextEditingController(); //'ชื่อ'
  TextEditingController curatoraddressControllerone =
      TextEditingController(); //'ข้อมูลที่ติดต่อได้'
  String? curatorName;
  String? curatorAddress;

  Future<Null> processEditData() async {
    if (map.isEmpty) {
      normalDialog(context, 'ไม่มีการเปลี่ยนแปลง');
    } else {
      await Firebase.initializeApp().then((value) async {
        await FirebaseFirestore.instance
            .collection('Curator')
            .doc(widget.idcard)
            .update(map)
            .then((value) => Navigator.pop(context));
      });
    }
  }

  Future<Null> readAlldata() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('Curator')
          .doc('${widget.idcard}')
          .snapshots()
          .listen((event) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            curatorName = event['curatorname'];
            curatorAddress = event['curatoraddress'];
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filedOne(),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column filedOne() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'ชื่อ-สกุล',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['curatorname'] = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ชื่อ-สกุล';
            } else {
              return null;
            }
          },
          controller: curatornameControllerone,
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
        Container(
          width: 320,
          child: Text(
            'ข้อมูลที่สามารถติดต่อได้',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (value) {
            map['curatoraddress'] = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ข้อมูลที่สามารถติดต่อได้';
            } else {
              return null;
            }
          },
          controller: curatoraddressControllerone,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ข้อมูลที่สามารถติดต่อได้',
            labelText: 'ข้อมูลที่สามารถติดต่อได้ ',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }
}
