import 'dart:math';
import 'package:bedridden/Screen/Home/listledit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/sick_model.dart';
import 'dart:developer' as dev;

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  double currentLat =
      0.0; //ตัวแปรที่ประกาศค่ามาเก็บ lat ที่ได้จากการดึงตำแหน่งปัจุันของผู้ใช้
  double currentLng =
      0.0; //ตัวแปรที่ประกาศค่ามาเก็บ lng ที่ได้จากการดึงตำแหน่งปัจุันของผู้ใช้
  double? lat1, lng1, lat2, lng2;
  String? distanceString;
  late SickModel model;

  List<SickModel> sickmodels = [];
  List<int> distancelist = [];

  @override
  void initState() {
    super.initState();
    findLat1Lng1();
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

  Future<Null> readAllSick() async {
    Future.delayed(Duration(microseconds: 30));
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        //หาระยะทางทั้งหมดจากผู้ใช้กับผู้ป่วยทั้งหมด
        for (var item in event.docs) {
          model = SickModel.fromMap(item.data());
          print('## name ==> ${model.name}');
          print('## idCard ==> ${model.idCard}');
          var latdistance = model.lat;
          var lngdistance = model.lng;
          model.ditance = calculateDistance(
            currentLat,
            currentLng,
            latdistance,
            lngdistance,
          );
          //ได้ระยะทางทั้งหมดแล้วนำมาเพิ่มใส่ model
          setState(() {
            if (sickmodels != null) {
              sickmodels.add(model);
            }
          });
        }
        //หา distance
        for (var i = 0; i < sickmodels.length -1; i++) {
          double latfirst = sickmodels.first.lat;
          double lngfirst = sickmodels.first.lng;
          double lat = sickmodels[i].lng;
          double lng = sickmodels[i].lng;
          sickmodels[i].ditance = calculateDistance(
            latfirst,
            lngfirst,
            lat,
            lng,
          );
        }
        //นำข้อมูลใน model ที่จะเรียกใช้ใน widget มาจัดลำดับจากน้อยไปมากด้วยข้อมูลระยะทาง ditance ที่ทำการเพิ่มเข้าไป
        sortDataSickModel();
        //
      });
    });
  }

  sortDataSickModel() {
    sickmodels.sort((a, b) {
      var distanceA = a.ditance ?? 0.0;
      var distanceB = b.ditance ?? 0.0;
      return distanceA.compareTo(distanceB);
    });
  }

  Future<Null> findLat1Lng1() async {
    findLocationData().then((value) {
      setState(() {
        currentLat = value?.latitude ?? 0.0;
        currentLng = value?.longitude ?? 0.0;
        readAllSick();
      });
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
      body: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: sickmodels.length,
          itemBuilder: (context, index) {
            var myFormat = NumberFormat('#0.0#', 'en_US');
            distanceString = myFormat.format(sickmodels[index].ditance);
            return buildListview(index);
          }),
    );
  }

  Expanded buildListview(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _launchMap(sickmodels[index].lat, sickmodels[index].lng);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 3, color: Colors.grey),
                  image: DecorationImage(
                      image: NetworkImage(sickmodels[index].urlImage),
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sickmodels[index].name,
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
                        Text(sickmodels[index].address,
                            style: TextStyle(
                                color: const Color(0xffdfad98),
                                fontSize: 13,
                                letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.navigation,
                          color: const Color(0xffdfad98),
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('$distanceString กม.',
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
  }
}
