import 'package:bedridden/Screen/Home/listledit.dart';
import 'package:bedridden/models/environment_model.dart';
import 'package:bedridden/models/family_model.dart';
import 'package:bedridden/models/health_model.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Listl2 extends StatefulWidget {
  const Listl2({Key? key}) : super(key: key);

  @override
  _Listl2State createState() => _Listl2State();
}

class _Listl2State extends State<Listl2> {
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);

  get padding => null;

  List<SickModel> sickmodels = [];
  List<SickModel> sickmodelsLevel1 = [];
  List<SickModel> sickmodelsLevel2 = [];
  List<SickModel> sickmodelsLevel3 = [];
  List<String> docIds = [];

  List<HealthModel> healthModel = [];
  List<EnvironmentModel> environmentModel = [];
  List<FamilyModel> familyModel = [];

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
        docIds.clear();
        healthModel.clear();
        environmentModel.clear();
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
              docIds.add(item.id);
            }
            if (model.level == '2') {
              sickmodelsLevel2.add(model);
              docIds.add(item.id);
            }
            if (model.level == '3') {
              sickmodelsLevel3.add(model);
              docIds.add(item.id);
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายชื่อผู้ป่วย ระดับที่ 2',
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [buildtListNameAllBedriddenLevel2()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildtListNameAllBedriddenLevel2() {
    return sickmodelsLevel2.length == 0
        ? ShowProgress()
        : Container(
             height: 1000,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 200 / 300,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: sickmodelsLevel2.length,
              itemBuilder: (context, index) => Container(
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    var idcard = sickmodels[index].idCard;
                    print('## idcard = $idcard');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LitlEdit(idcard: idcard)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    child: Card(
                      color: Color(0xffFFD1BB),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              width: 130,
                              height: 80,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  sickmodelsLevel2[index].urlImage,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, exception, stackTrack) =>
                                          Icon(Icons.error),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  width: 140,
                                  child: Text(
                                    sickmodelsLevel2[index].name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  width: 140,
                                  child: Text(sickmodelsLevel2[index].address),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  width: 140,
                                  child: Text(
                                      'ระดับที่ ${sickmodelsLevel2[index].level}'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
