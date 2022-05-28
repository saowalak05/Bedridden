import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../../models/sick_model.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  double currentLat = 0.0;
  double currentLng = 0.0;
  double? lat1, lng1, lat2, lng2, distance;
  String? distanceString;

  List<SickModel> sickmodels = [];

  @override
  void initState() {
    super.initState();
    findLat1Lng1();
  }

  Future<Null> readAllSick() async {
    Future.delayed(Duration(microseconds: 30));
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        for (var item in event.docs) {
          SickModel model = SickModel.fromMap(item.data());
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
          print('lat1 =$lat1, lng1 = $lng1, lat2 =$lat2, lng2 = $lng2');
          print('distance = $distance');
          setState(() {
            if (sickmodels != null) {
              sickmodels.add(model);
            }
          });
        }
        sortDataSickModel();
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
    );
  }
}
