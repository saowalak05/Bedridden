import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/sick_model.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  double currentLat = 0.0;
  double currentLng = 0.0;

  List<PatienPath> listPatientPathTmp = [];
  List<PatienPath> listPatientPath = []; //list ใช้เก็บข้อมูลที่ได้จากการ
  List<SickModel> listPatient = []; 

  @override
  void initState() {
    super.initState();
    findLat1Lng1();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<PatienPath> buildlistPatientPathTmp(
      double currentLat, double currentLng) {
    List<PatienPath> _listPatientPathTmp = [];
    // calculate distance from current location คำนวณระยะทางจากตำแหน่งปัจจุบัน
    dev.log('patient total = ${listPatient.length}');
    for (int i = 0; i < listPatient.length; i++) {
      var lat1 = currentLat;
      var lng1 = currentLng;
      var lat2 = listPatient[i].lat;
      var lng2 = listPatient[i].lng;

      // calculate distance คำนวณระยะทาง
      var distance = calculateDistance(lat1, lng1, lat2, lng2);
      dev.log('${listPatient[i].name} - ${listPatient[i].idCard} - $distance');
      // add to temp path list เพิ่มในรายการ
      _listPatientPathTmp
          .add(PatienPath(docId: listPatient[i].idCard, distance: distance));
    }

    return _listPatientPathTmp;
  }

  List<SickModel> listPatientData = [];

  readAllSick() async {
    // read all patient to list อ่านค่าทั้งหมดในรายการ
    FirebaseFirestore.instance.collection('sick').get().then((value) {
      // set data to patient list ตั้งค่าข้อมูล
      for (var doc in value.docs) {
        SickModel patient = SickModel.fromMap(doc.data());
        //dev.log('name = ${patient.name}');
        listPatient.add(patient);
        listPatientData.add(patient);
      }

      dev.log('total patient ${listPatient.length}');

      // calculate paths คำนวณเส้นทาง
      while (listPatient.length > 0) {
        // build pateint path list สร้างรายการเดินเส้น
        if (listPatientPath.length <= 0) {
          dev.log('currentLat = $currentLat, currentLng = $currentLng');
          listPatientPathTmp = buildlistPatientPathTmp(currentLat, currentLng);
        } else {
          // get lat, lon from patial list 
          // dev.log('total patient = ${listPatient.length}');
          // dev.log('last patient path = ${listPatientPath.last.docId}');
          final item = listPatientData.firstWhere(
              (element) => element.idCard == listPatientPath.last.docId);
          dev.log('currentLat = ${item.lat}, currentLng = ${item.lng}');
          listPatientPathTmp = buildlistPatientPathTmp(item.lat, item.lng);
        }

        // sort tmp path list จัดลำดับระยะจากน้อยไปมาก
        listPatientPathTmp.sort((a, b) => a.distance.compareTo(b.distance));
        dev.log(
            'shortes path is ${listPatientPathTmp.first.docId} , ${listPatientPathTmp.first.distance} ');

        // set data to patient path list 
        listPatientPath.add(PatienPath(
            docId: listPatientPathTmp.first.docId,
            distance: listPatientPathTmp.first.distance));

        // remove patient in list patient
        listPatient.removeWhere(
            (element) => element.idCard == listPatientPathTmp.first.docId);

        // remove first patient in temp
        listPatientPathTmp.removeAt(0);

        dev.log('list Patient Path Tmp length = ${listPatientPathTmp.length}');

        // dev.log('list patient length = ${listPatient.length}');
        // dev.log('list patient path length = ${listPatientPath.length}');
      }

      dev.log('list patient path = ${listPatientPath.length}');

      setState(() {});
    });
  }

  Future<Null> findLat1Lng1() async {
    findLocationData().then((value) {
      // setState(() {
      currentLat = value?.latitude ?? 0.0;
      currentLng = value?.longitude ?? 0.0;
      dev.log('currentLat = $currentLat, currentLng = $currentLng');
      readAllSick();
      //});
    });
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  _launchMap(double lat, double lng) async {
    print('mapppp $lat $lng');
    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'could not open the map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffede5),
      appBar: AppBar(
        title: Center(
          child: Text(
            'คำนวณระยะทาง',
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
      body: (listPatientPath.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: listPatientPath.length,
                itemBuilder: (context, index) {
                  // get patient data
                  final patient = listPatientData.firstWhere((element) =>
                      element.idCard == listPatientPath[index].docId);
                  return GestureDetector(
                    child: GestureDetector(
                      onTap: () {
                        _launchMap(patient.lat, patient.lng);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 3, color: Colors.grey),
                                image: DecorationImage(
                                    image: NetworkImage(patient.urlImage),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    patient.name,
                                    style: TextStyle(
                                        color: const Color(0xffdfad98),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: const Color(0xffdfad98),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(patient.address,
                                          style: TextStyle(
                                              color: const Color(0xffdfad98),
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: Text('ลำดับ $index',
                                    style: TextStyle(
                                        color: const Color(0xffdfad98),
                                        fontSize: 13,
                                        letterSpacing: .3))),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class PatienPath {
  String docId;
  double distance;
  PatienPath({
    required this.docId,
    required this.distance,
  });
}
