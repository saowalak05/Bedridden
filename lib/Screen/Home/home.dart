import 'package:bedridden/Screen/Addbedridden/add.dart';
import 'package:bedridden/Screen/Home/listall.dart';
import 'package:bedridden/Screen/Home/listl1.dart';
import 'package:bedridden/Screen/Home/listl2.dart';
import 'package:bedridden/Screen/Home/listl3.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'listledit.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);


  List<SickModel> sickmodels = [];
  List<SickModel> sickmodelsLevel1 = [];
  List<SickModel> sickmodelsLevel2 = [];
  List<SickModel> sickmodelsLevel3 = [];
  List<String> docIds = [];

  @override
  void initState() {
    super.initState();
    readAllSick();
  }

  Future<Null> navigater(SickModel model, int index) async {
    await FirebaseFirestore.instance
        .collection('sick')
        .doc(model.idCard)
        .delete()
        .then((value) => LitlEdit);
  }

  Future<Null> readAllSick() async {
    Future.delayed(Duration(seconds: 1));
    if (sickmodels.length != 0) {
      sickmodels.clear();
      sickmodelsLevel1.clear();
      sickmodelsLevel2.clear();
      sickmodelsLevel3.clear();
      docIds.clear();
    }

    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        for (var item in event.docs) {
          SickModel model = SickModel.fromMap(item.data());
          print('## name ==> ${model.name}');
          print('## idCard ==> ${model.idCard}');
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
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(
          'หน้าหลัก',
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
      body: RefreshIndicator(
        onRefresh: readAllSick,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    buildtTtleListNameAllBedridden(), //'รายชื่อผู้ป่วยติดเตียง,โชว์ทั้งหมด'
                    buildtListNameAllBedridden(), //'รายชื่อผู้ป่วยติดเตียง'
                    buildtTtleListNameAllBedriddenLevel1(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1,โชว์ทั้งหมด'
                    buildtListNameAllBedriddenLevel1(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1'
                    buildtTtleListNameAllBedriddenLevel2(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 2,โชว์ทั้งหมด'
                    buildtListNameAllBedriddenLevel2(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 2'
                    buildtTtleListNameAllBedriddenLevel3(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 3,โชว์ทั้งหมด'
                    buildtListNameAllBedriddenLevel3(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 3'
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add()));
        },
        backgroundColor: Color(0xfff29a94),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names

  Widget buildtListNameAllBedriddenLevel3() {
    return sickmodelsLevel3.length == 0
        ? Container(
            child: Text('ไม่พบรายชื่อ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        : Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: sickmodelsLevel3.length,
              itemBuilder: (context, index) => Container(
                width: 175,
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
                                  sickmodelsLevel3[index].urlImage,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
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
                                    sickmodelsLevel3[index].name,
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
                                  child: Text(sickmodelsLevel3[index].address),
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
                                      'ระดับที่ ${sickmodelsLevel3[index].level}'),
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

  Row buildtTtleListNameAllBedriddenLevel3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย ระดับที่ 3",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Listl3();
                  },
                ),
              );
            },
            child: Text(
              "ทั้งหมด",
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    );
  }

  Widget buildtListNameAllBedriddenLevel2() {
    return sickmodelsLevel2.length == 0
        ? Container(
            child: Text('ไม่พบรายชื่อ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        : Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: sickmodelsLevel2.length,
              itemBuilder: (context, index) => Container(
                width: 175,
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
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
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

  Row buildtTtleListNameAllBedriddenLevel2() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย ระดับที่ 2",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Listl2();
                  },
                ),
              );
            },
            child: Text(
              "ทั้งหมด",
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    );
  }

//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1'
  Widget buildtListNameAllBedriddenLevel1() {
    return sickmodelsLevel1.length == 0
        ? Container(
            child: Text('ไม่พบรายชื่อ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        : Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: sickmodelsLevel1.length,
              itemBuilder: (context, index) => Container(
                width: 175,
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
                                  sickmodelsLevel1[index].urlImage,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
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
                                    sickmodelsLevel1[index].name,
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
                                  child: Text(sickmodelsLevel1[index].address),
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
                                      'ระดับที่ ${sickmodelsLevel1[index].level}'),
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

//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1,โชว์ทั้งหมด'
  Row buildtTtleListNameAllBedriddenLevel1() {
    var textButton = TextButton(
      style: TextButton.styleFrom(primary: Colors.black87),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Listl();
            },
          ),
        );
      },
      child: Text(
        "ทั้งหมด",
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย ระดับที่ 1",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        textButton,
      ],
    );
  }

//'รายชื่อผู้ป่วยติดเตียง'

  Widget buildtListNameAllBedridden() {
    return sickmodels.length == 0
        ? Container(
            child: Text('ไม่พบรายชื่อ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        : Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: sickmodels.length,
              itemBuilder: (context, index) => Container(
                width: 175,
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
                                  sickmodels[index].urlImage,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
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
                                    sickmodels[index].name,
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
                                  child: Text(sickmodels[index].address),
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
                                      'ระดับที่ ${sickmodels[index].level}'),
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

//'รายชื่อผู้ป่วยติดเตียง,โชว์ทั้งหมด'
  Row buildtTtleListNameAllBedridden() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return All();
                  },
                ),
              );
            },
            child: Text(
              "ทั้งหมด",
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    );
  }
}
