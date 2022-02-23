import 'package:bedridden/models/environment_model.dart';
import 'package:bedridden/models/family_model.dart';
import 'package:bedridden/models/health_model.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LitlEdit extends StatefulWidget {
  const LitlEdit(SickModel sickmodel, int index, {Key? key}) : super(key: key);

  @override
  _LitlEditState createState() => _LitlEditState();
}

class _LitlEditState extends State<LitlEdit> {
  List<SickModel> sickmodels = [];
  List<SickModel> sickmodelsLevel1 = [];
  List<SickModel> sickmodelsLevel2 = [];
  List<SickModel> sickmodelsLevel3 = [];
  List<String> idCard = [];
  List<HealthModel> healthModel = [];
  List<EnvironmentModel> environmentModel = [];
  List<FamilyModel> familyModel = [];

  late int index;

  @override
  void initState() {
    super.initState();
    readAllSick();
  }

  Future<Null> readAllSick() async {
    if (sickmodels.length != 0) {
      sickmodels.clear();
      sickmodelsLevel1.clear();
      sickmodelsLevel2.clear();
      sickmodelsLevel3.clear();
      idCard.clear();
    } else if (healthModel.length != 0) {
      healthModel.clear();
    } else if (environmentModel.length != 0) {
      environmentModel.clear();
    } else if (familyModel.length != 0) {
      familyModel.clear();
    }

    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        for (var item in event.docs) {
          SickModel model = SickModel.fromMap(item.data());
          print('## name ==> ${model.name}');
          setState(() {
            sickmodels.add(model);
            if (model.level == '1') {
              sickmodelsLevel1.add(model);
              idCard.add(item.id);
            }
            if (model.level == '2') {
              sickmodelsLevel2.add(model);
              idCard.add(item.id);
            }
            if (model.level == '3') {
              sickmodelsLevel3.add(model);
              idCard.add(item.id);
            }
          });
        }
      });
      FirebaseFirestore.instance
          .collection('Health')
          .doc('1111111155555')
          .snapshots()
          .listen((event) {
        print(' ==> $event');
      });
      FirebaseFirestore.instance
          .collection('environment')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          EnvironmentModel model = EnvironmentModel.fromMap(item.data());
          print('## environment ==> ${model.accommodation}');
          setState(() {});
        }
      });
      FirebaseFirestore.instance
          .collection('Family')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          FamilyModel model = FamilyModel.fromMap(item.data());
          print('## Family ==> ${model.familynameone}');
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประวัติผู้ป่วย',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0))),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            Container(
              child: recordSick(),
            )
          ],
        ),
      )),
    );
  }

  Widget recordSick() {
    return Column(
      children: [],
    );
  }
}
