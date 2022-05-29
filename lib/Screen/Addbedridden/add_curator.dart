import 'package:bedridden/models/curator_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Addcurator extends StatefulWidget {
  final String idCard;
  const Addcurator({Key? key, required this.idCard}) : super(key: key);

  @override
  State<Addcurator> createState() => _AddcuratorState();
}

class _AddcuratorState extends State<Addcurator> {
  final formkey = GlobalKey<FormState>();
  TextEditingController curatornameControllerone =
      TextEditingController(); //'ชื่อ'
  TextEditingController curatoraddressControllerone =
      TextEditingController(); //'ข้อมูลที่ติดต่อได้'

  @override
  void initState() {
    super.initState();
    print(widget.idCard);
  }

  @override
  Widget build(BuildContext context) {
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
          'ส่วนที่ 5 ข้อมูลผู้ดูแลผู้ป่วย',
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
              filedOne(),
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
            proccessUplodCurator();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Future<Null> proccessUplodCurator() async {
    await Firebase.initializeApp().then((value) async {
      CuratorModel model = CuratorModel(
        curatorname: curatornameControllerone.text,
        curatoraddress: curatoraddressControllerone.text,
      );

      await FirebaseFirestore.instance
          .collection('Curator')
          .doc(
            '${widget.idCard}',
          )
          .set(model.toMap())
          .then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
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
                'ชื่อ-สกุล',
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
        TextFormField(
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
