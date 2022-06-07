import 'dart:io';
import 'dart:math';

import 'package:bedridden/Screen/edit_curator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bedridden/Screen/edit_environment.dart';
import 'package:bedridden/Screen/edit_family.dart';
import 'package:bedridden/Screen/edit_health.dart';
import 'package:bedridden/Screen/edit_sick.dart';
import 'package:bedridden/models/environment_model.dart';
import 'package:bedridden/models/family_model.dart';
import 'package:bedridden/models/health_model.dart';
import 'package:bedridden/models/sick_model.dart';

import 'dart:developer' as dev;

class LitlEdit extends StatefulWidget {
  final String idcard;

  const LitlEdit({Key? key, required this.idcard}) : super(key: key);

  @override
  _LitlEditState createState() => _LitlEditState();
}

String dropdownValue = '';

List<SickModel> sickmodels = [];
List<SickModel> sickmodelsLevel1 = [];
List<SickModel> sickmodelsLevel2 = [];
List<SickModel> sickmodelsLevel3 = [];
List<HealthModel> healthModel = [];
List<EnvironmentModel> environmentModel = [];
List<FamilyModel> familyModel = [];

//sick
String? addressSick;
String? bondSick;
String? idCardSick;
String? latSick;
String? levelSick;
String? lngSick;
String? nameSick;
String? nationalitySick;
String? patientoccupationSick;
String? phoneSick;
String? raceSick;
String? religionSick;
String? talentSick;
String? typeSexSick;
String? typeStatusSick;
String? typeeducationlevelSick;
String? typepositionSick;

String? urlImageSick;
//Health
String? diseaseHealth;
String? foodsupplementHealth;
String? groupAHealth;
String? groupBHealth;
String? herbHealth;
String? medicineHealth;
// environment
String? accommodationenvironment;
String? typeHomeEnvironmentenvironment;
String? typeHouseenvironment;
String? typeHousingSafetyenvironment;
String? typefacilitiesenvironment;
String? urlenvironmentImageenvironment;
//Family
String? familynameoneFamily;
String? familynametwoFamily;
String? familynamethreeFamily;
String? familynamefourFamily;
String? familyrelationshiponeFamily;
String? familyrelationshipthreeFamily;
String? familyrelationshiptwoFamily;
String? familyrelationshipfourFamily;
String? occupationoneFamily;
String? occupationthreeFamily;
String? occupationtwoFamily;
String? occupationfourFamily;

String? curatorName;
String? curatorAddress;

double? lat;
double? lng;

File? file;
String? colorName;
Color? color;

class _LitlEditState extends State<LitlEdit> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    readAlldata();
  }

  _launchMap() async {
    print('mapppp $latSick $lngSick');
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$latSick,$lngSick";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'could not open the map';
    }
  }

  CircleAvatar circleFile() {
    return CircleAvatar(
      backgroundImage: FileImage(file!),
    );
  }

  CircleAvatar circleNetwork() {
    return CircleAvatar(
      backgroundImage: NetworkImage(urlImageSick!),
    );
  }

  Container circleAsset() {
    return Container(
      width: 200,
      child: Image.network(
        '$urlImageSick',
        errorBuilder: (context, exception, stackTrack) => Icon(Icons.error),
      ),
    );
  }

  Future<Null> processChangeImageProfile() async {
    String urlImage = 'sick${Random().nextInt(100000)}.jpg';
    print('## nameImage ==>> $urlImage');
    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('sick/$urlImage');
      UploadTask task = reference.putFile(file!);
      await task.whenComplete(() async {});
    });
  }

  Future<Null> processGetImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Future<Null> readAlldata() async {
    await Firebase.initializeApp().then((value) async {
      QuerySnapshot lastLog = await FirebaseFirestore.instance
          .collection('Health')
          .doc(widget.idcard)
          .collection('logs')
          .get();
      setState(() {
        dropdownValue = lastLog.docs.last.id;
      });

      dev.log('found log data = ${lastLog.docs.length} items');
      dev.log('found log last = ${lastLog.docs.last.id} items');

      if (lastLog.docs.length == 0) {
        await Firebase.initializeApp().then((value) async {
          FirebaseFirestore.instance
              .collection('sick')
              .doc(widget.idcard)
              .snapshots()
              .listen((event) {
            DateTime dateTime = event['bond'].toDate();
            DateFormat dateFormat = DateFormat('dd-MMMM-yyyy', 'th');
            String bondStr = dateFormat.format(dateTime);
            setState(() {
              addressSick = event['address'];
              bondSick = bondStr;
              idCardSick = event['idCard'];
              latSick = event['lat'].toString();
              lngSick = event['lng'].toString();
              levelSick = event['level'];
              nameSick = event['name'];
              nationalitySick = event['nationality'];
              patientoccupationSick = event['patientoccupation'];
              phoneSick = event['phone'];
              raceSick = event['race'];
              religionSick = event['religion'];
              talentSick = event['talent'];
              typeSexSick = event['typeSex'];
              typeStatusSick = event['typeStatus'];
              typeeducationlevelSick = event['typeeducation_level'].toString();
              typepositionSick = event['typeposition'].toString();
              urlImageSick = event['urlImage'];
            });
          });
          FirebaseFirestore.instance
              .collection('Health')
              .doc(widget.idcard)
              .snapshots()
              .listen((event) {
            setState(() {
              diseaseHealth = event['disease'];
              foodsupplementHealth = event['foodsupplement'];
              groupAHealth = event['groupA'];
              groupBHealth = event['groupB'];
              herbHealth = event['herb'];
              medicineHealth = event['medicine'];
            });
          });
          FirebaseFirestore.instance
              .collection('environment')
              .doc('${widget.idcard}')
              .snapshots()
              .listen((event) {
            setState(() {
              accommodationenvironment = event['accommodation'];
              typeHomeEnvironmentenvironment = event['typeHomeEnvironment'];
              typeHouseenvironment = event['typeHouse'];
              typeHousingSafetyenvironment = event['typeHousingSafety'];
              typefacilitiesenvironment = event['typefacilities'];
              urlenvironmentImageenvironment = event['urlenvironmentImage'];
            });
          });

          FirebaseFirestore.instance
              .collection('Family')
              .doc('${widget.idcard}')
              .snapshots()
              .listen((event) {
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

          FirebaseFirestore.instance
              .collection('Curator')
              .doc('${widget.idcard}')
              .snapshots()
              .listen((event) {
            setState(() {
              curatorName = event['curatorname'];
              curatorAddress = event['curatoraddress'];
            });
          });
        });
      } else {
        FirebaseFirestore.instance
            .collection('sick')
            .doc(widget.idcard)
            .snapshots()
            .listen((event) {
          DateTime dateTime = event['bond'].toDate();
          DateFormat dateFormat = DateFormat('dd-MMMM-yyyy', 'th');
          String bondStr = dateFormat.format(dateTime);
          setState(() {
            addressSick = event['address'];
            bondSick = bondStr;
            idCardSick = event['idCard'];
            latSick = event['lat'].toString();
            lngSick = event['lng'].toString();
            levelSick = event['level'];
            nameSick = event['name'];
            nationalitySick = event['nationality'];
            patientoccupationSick = event['patientoccupation'];
            phoneSick = event['phone'];
            raceSick = event['race'];
            religionSick = event['religion'];
            talentSick = event['talent'];
            typeSexSick = event['typeSex'];
            typeStatusSick = event['typeStatus'];
            typeeducationlevelSick = event['typeeducation_level'].toString();
            typepositionSick = event['typeposition'].toString();
            urlImageSick = event['urlImage'];
          });
        });
        FirebaseFirestore.instance
            .collection('Health')
            .doc(widget.idcard)
            .collection('logs')
            .doc(dropdownValue)
            .get()
            .then((DocumentSnapshot event) {
          setState(() {
            diseaseHealth = event['disease'];
            foodsupplementHealth = event['foodsupplement'];
            groupAHealth = event['groupA'];
            groupBHealth = event['groupB'];
            herbHealth = event['herb'];
            medicineHealth = event['medicine'];
          });
        });

        FirebaseFirestore.instance
            .collection('environment')
            .doc('${widget.idcard}')
            .snapshots()
            .listen((event) {
          setState(() {
            accommodationenvironment = event['accommodation'];
            typeHomeEnvironmentenvironment = event['typeHomeEnvironment'];
            typeHouseenvironment = event['typeHouse'];
            typeHousingSafetyenvironment = event['typeHousingSafety'];
            typefacilitiesenvironment = event['typefacilities'];
            urlenvironmentImageenvironment = event['urlenvironmentImage'];
          });
        });

        FirebaseFirestore.instance
            .collection('Family')
            .doc('${widget.idcard}')
            .snapshots()
            .listen((event) {
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

        FirebaseFirestore.instance
            .collection('Curator')
            .doc('${widget.idcard}')
            .snapshots()
            .listen((event) {
          setState(() {
            curatorName = event['curatorname'];
            curatorAddress = event['curatoraddress'];
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ประวัติผู้ป่วย',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0))),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  // padding: EdgeInsets.all(50.0),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.width / 2.5,
                  child: file != null
                      ? circleFile()
                      : urlImageSick != null
                          ? circleNetwork()
                          : circleAsset(),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ชื่อ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '$nameSick',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'ระดับ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '$levelSick',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("ส่วนที่ 1 ข้อมูลของผู้ป่วย",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 70,
                    )),
              ),
            ]),
            SizedBox(height: 10),
            Text('เลขบัตรประจำตัวประชาชน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$idCardSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('วัน/เดือน/ปีเกิด',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$bondSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('เพศ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeSexSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สถานะ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeStatusSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ที่อยู่ปัจจุบัน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$addressSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('พิกัดที่อยู่',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Text('lat : ', style: TextStyle(fontSize: 16)),
                Text('$latSick ', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text('lng : ', style: TextStyle(fontSize: 16)),
                Text('$lngSick', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Text('เบอร์โทรศัพท์',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$phoneSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('เชื้อชาติ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$raceSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สัญชาติ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$nationalitySick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ศาสนา',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$religionSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ระดับการศึกษา',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeeducationlevelSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ก่อนป่วยติดเตียงผู้ป่วยทำอาชีพ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$patientoccupationSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ความสามารถพิเศษ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$talentSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ฐานะของผู้และครอบครัว',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typepositionSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("ส่วนที่ 2 ข้อมูลด้านสุขภาพ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 70,
                    )),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("ประวัติข้อมูล",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Center(
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xffdfad98),
                        border: Border.all()),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Health')
                          .doc(widget.idcard)
                          .collection('logs')
                          .snapshots(),
                      builder: (context, snapshot) {
                        // (1) has error or snapshot no data, show loading
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('ไม่พบข้อมูล'),
                          );
                        }

                        // (2) snapshot has data
                        if (snapshot.hasData) {
                          // (3) check if data is empty show no data
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('ไม่มีประวัติ'),
                            );
                          } else {
                            // (4) if data is not empty, show dropdown
                            final doc = snapshot.data!.docs;
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text('เลือกประวัติ'),
                                items: doc.map((e) {
                                  // (5) format your datetime here
                                  return DropdownMenuItem<String>(
                                    child: Text(e["timestamp"]),
                                    value: e.id,
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  // (6) set value to drop down here
                                  dev.log('goto page with docId = $value');
                                  snapshot.data!.docs
                                      .where((e) => e.id == value)
                                      .forEach((e) {
                                    dev.log('${e.data()}');
                                    setState(() {
                                      dropdownValue = value.toString();
                                      // set your value here
                                      diseaseHealth = e['disease'];
                                      medicineHealth = e['medicine'];
                                      groupAHealth = e['groupA'];
                                      groupBHealth = e['groupB'];
                                      herbHealth = e['herb'];
                                      foodsupplementHealth = e['foodsupplement'];
                                      dev.log(e["timestamp"]);
                                    });
                                  });
                                  dev.log('goto page with docId = $value');
                                },
                                value: (dropdownValue == '')
                                    ? '${doc.last.id}'
                                    : dropdownValue,
                              ),
                            );
                          }
                        }
                        return const Center(child: Text('loading...'));
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text('โรคประจำตัวหรือปัญหาสุขภาพ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$diseaseHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ยาที่แพทย์สั่ง',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$medicineHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ผลการตรวจสอบ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$groupAHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('การใช้ยา',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$groupBHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สมุนไพร',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$herbHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('อาหารเสริม',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$foodsupplementHealth', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("ส่วนที่ 3 ข้อมูลสภาพแวดล้อม",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 70,
                    )),
              ),
            ]),
            SizedBox(height: 10),
            Text('สถานะของที่พักอาศัย',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$accommodationenvironment', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ประเภทบ้าน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeHouseenvironment', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สภาพสิ่งแวดล้อมในบ้าน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeHomeEnvironmentenvironment',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ความปลอดภัยของที่อยู่อาศัย',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeHousingSafetyenvironment',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สิ่งอำนวยความสะดวก',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typefacilitiesenvironment', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('รูปสภาพแวดล้อม',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  '$urlenvironmentImageenvironment',
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrack) => Icon(
                    Icons.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("ส่วนที่ 4 ข้อมูลเครือญาติผู้ป่วย",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 70,
                    )),
              ),
            ]),
            SizedBox(height: 10),
            Text('ข้อมูลความสัมพันธ์กับสมาชิกในครอบครัว',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xfff29a94),
                      child: Text('บิดา',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ))),
                    Expanded(
                        child: Container(
                            child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xfff29a94),
                      child: Text('มารดา',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('ชื่อ-สกุล :$familynameoneFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('ชื่อ-สกุล :$familynametwoFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('อาชีพ : $occupationoneFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('อาชีพ : $occupationtwoFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 30,
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 30,
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black, //color of divider
              height: 0, //height spacing of divider
              thickness: 3, //thickness of divier line
              indent: 90, //spacing at the start of divider
              endIndent: 90, //spacing at the end of divider
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 30,
                width: 3,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // padding: EdgeInsets.all(50.0),
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.width / 3.5,
                    child: file != null
                        ? circleFile()
                        : urlImageSick != null
                            ? circleNetwork()
                            : circleAsset(),
                  )),
            ),
            Center(
              child: Text(
                '$nameSick',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 30,
                width: 3,
                color: Colors.black,
              ),
            ),
            Divider(
              color: Colors.black, //color of divider
              height: 0, //height spacing of divider
              thickness: 3, //thickness of divier line
              indent: 90, //spacing at the start of divider
              endIndent: 90, //spacing at the end of divider
            ),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 30,
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 30,
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xfff29a94),
                      child: Text('ลูกคนที่ 1',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ))),
                    Expanded(
                        child: Container(
                            child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xfff29a94),
                      child: Text('ลูกคนที่ 2',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ))),

                    // Expanded(
                    //     child: Container(
                    //   child: CircleAvatar(
                    //       foregroundColor: Colors.blue,
                    //       backgroundColor: Colors.white,
                    //       radius: 70.0,
                    //       child: ClipOval(
                    //         child: Image.network(
                    //           '$urlenvironmentImageenvironment',
                    //           fit: BoxFit.cover,
                    //           width: 120.0,
                    //           height: 120.0,
                    //         ),
                    //       )),
                    // )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('ชื่อ-สกุล : $familynamethreeFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('ชื่อ-สกุล : $familynamefourFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('อาชีพ : $occupationthreeFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text('อาชีพ : $occupationfourFamily',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      height: 50,
                    )),
              ),
              Text("ส่วนที่ 5 ข้อมูลผู้ดูแลผู้ป่วย",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 70,
                    )),
              ),
            ]),
            SizedBox(height: 10),
            Text('ชื่อ-นามสุกล',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$curatorName', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ข้อมูลที่สามารถติดต่อได้',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$curatorAddress', style: TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
      //นำทาง

      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 231, 172, 11),
            label: 'แก้ไข ข้อมูลของผู้ป่วย',
            onPressed: () {
              var idcard = widget.idcard;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditSick(idcard: idcard),
                  ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 231, 172, 11),
            label: 'แก้ไข ข้อมูลด้านสุขภาพ',
            onPressed: () {
              var idcard = widget.idcard;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditHealth(idcard: idcard),
                  ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 231, 172, 11),
            label: 'แก้ไข ข้อมูลสภาพแวดล้อม',
            onPressed: () {
              var idcard = widget.idcard;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEnvironment(idcard: idcard),
                  ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 231, 172, 11),
            label: 'แก้ไข ข้อมูลเครือญาติ',
            onPressed: () {
              var idcard = widget.idcard;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditFamily(idcard: idcard),
                  ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 231, 172, 11),
            label: 'แก้ไข ข้อมูลผู้ดูแลผู้ป่วย',
            onPressed: () {
              var idcard = widget.idcard;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCurator(idcard: idcard),
                  ));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'ลบ',
            onPressed: () {
              confirmDelete();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.navigation),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'นำทาง',
            onPressed: () {
              _launchMap();
            },
          ),
        ],
        // closedForegroundColor: const Color(0xffdfad98),
        // openForegroundColor: const Color(0xffdfad98),
        closedBackgroundColor: const Color(0xfff29a94),
        openBackgroundColor: Color.fromARGB(255, 255, 143, 95),
      ),
    );
  }

  Future<Null> confirmDelete() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Icon(
            Icons.delete,
            size: 48,
            color: Colors.red,
          ),
          title: Text('ต้องการลบข้อมูล $nameSick หรือไม่ ?'),
          subtitle: Text('ถ้าลบแล้ว ไม่สามารถ กู้ คืนข้อมูลได้'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('sick')
                  .doc(widget.idcard)
                  .delete();
              await FirebaseFirestore.instance
                  .collection('Health')
                  .doc(widget.idcard)
                  .delete();
              await FirebaseFirestore.instance
                  .collection('environment')
                  .doc(widget.idcard)
                  .delete();
              await FirebaseFirestore.instance
                  .collection('Family')
                  .doc(widget.idcard)
                  .delete();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              print(sickmodels.length);
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
