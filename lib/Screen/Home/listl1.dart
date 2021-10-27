import 'package:bedridden/Screen/Home/listall.dart';
import 'package:bedridden/Screen/Home/listl1.dart';
import 'package:bedridden/Screen/Home/listl2.dart';
import 'package:bedridden/Screen/Home/listl3.dart';
import 'package:bedridden/Screen/edit_sick.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class listl1 extends StatefulWidget {
  const listl1({Key? key}) : super(key: key);

  @override
  _listl1State createState() => _listl1State();
}

class _listl1State extends State<listl1> {
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);

  get padding => null;

  List<SickModel> sickmodels = [];
  List<SickModel> sickmodelsLevel1 = [];
  List<SickModel> sickmodelsLevel2 = [];
  List<SickModel> sickmodelsLevel3 = [];
  List<String> docIds = [];

  @override
  void initState() {
    // TODO: implement initState
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
    }

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('sick')
          .snapshots()
          .listen((event) {
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
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //     padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        //     child: Image.asset(
        //       'assets/images/bedridden.png',
        //       fit: BoxFit.fitWidth,
        //     ),
        //   ),
        title: Text(
          'รายชื่อผู้ป่วย ระดับที่ 1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(50.0, 50.0))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [buildtListNameAllBedriddenLevel1()],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<Null> showSickDialog(SickModel model, int index) async {
    DateTime dateTime = model.bond.toDate();
    DateFormat dateFormat = DateFormat('dd-MMMM-yyyy', 'th');
    String bondStr = dateFormat.format(dateTime);

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(16),
        title: ListTile(
          leading: Container(
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                model.urlImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(model.name),
          subtitle: Text('ระดับที่ = ${model.level}'),
        ),
        children: [
          Text('รหัสบัตรประชาชน : ${model.idCard}'),
          Text('ที่อยู่ : ${model.address}'),
          Text('เบอร์โทรศัพท์ : ${model.phone}'),
          Text('เพศ : ${model.typeSex}'),
          Text('สถานภาพ : ${model.typeStatus}'),
          Text('วัน/เดือน/ปี เกิด : $bondStr'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditSick(
                          sickModel: model,
                          docId: docIds[index],
                        ),
                      )).then((value) => readAllSick());
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  confirmDelete(model, index);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }

//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1'
  Widget buildtListNameAllBedriddenLevel1() {
    return sickmodelsLevel1.length == 0
        ? ShowProgress()
        : Container(
            height: 650,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: sickmodelsLevel1.length,
                itemBuilder: (context, index) => Container(
                  width: 175,
                  child: GestureDetector(
                    onTap: () {
                      print('## You Click index = $index');
                      showSickDialog(sickmodelsLevel1[index], index);
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
                                    child:
                                        Text(sickmodelsLevel1[index].address),
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
            ),
          );
  }

  Future<Null> confirmDelete(SickModel model, int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Icon(
            Icons.delete,
            size: 48,
            color: Colors.red,
          ),
          title: Text('ต้องการลบข้อมูล ${model.name} หรือไม่ ?'),
          subtitle: Text('ถ้าลบแล้ว ไม่สามารถ กู้ คืนข้อมูลได้'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseFirestore.instance
                  .collection('sick')
                  .doc(docIds[index])
                  .delete()
                  .then((value) => readAllSick());
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
