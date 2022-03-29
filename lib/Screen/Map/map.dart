import 'dart:async';
import 'package:bedridden/Screen/Map/addlocation.dart';
import 'package:bedridden/models/location_model.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Choice {
  final String? title;
  final IconData? icon;
  final Color? color;
  const Choice({this.title, this.icon, this.color});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'โรงเรียน', icon: Icons.circle, color: Colors.green),
  const Choice(
      title: 'ร้านค้าใกล้บ้าน', icon: Icons.circle, color: Colors.amber),
  const Choice(title: 'สถานณีอนามัย', icon: Icons.circle, color: Colors.blue),
  const Choice(
      title: 'องค์การบริหารส่วนตำบล',
      icon: Icons.circle,
      color: Colors.pinkAccent),
  const Choice(title: 'โรงพยาบาล', icon: Icons.circle, color: Colors.purple),
  const Choice(title: 'วัด', icon: Icons.circle, color: Colors.cyanAccent),
];

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set(); //markers for google map

  List<SickModel> sickmodels = [];
  List<LocationModel> locationModel = [];

  Future<Null> readAlldata() async {
    setState(() {
      if (sickmodels.length != 0) {
        sickmodels.clear();
      }
    });
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        for (var item in event.docs) {
          SickModel model = SickModel.fromMap(item.data());
          print('sickmodels ====>>>${sickmodels.length}');
          setState(() {
            sickmodels.add(model);
            print('sickmodels ==${sickmodels.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < sickmodels.length; i++) {
              setState(() {
                markers.add(Marker(
                  markerId: MarkerId(sickmodels[i].name),
                  position: LatLng(sickmodels[i].lat, sickmodels[i].lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      sickmodels[i].level == '1'
                          ? BitmapDescriptor.hueYellow
                          : sickmodels[i].level == '2'
                              ? BitmapDescriptor.hueOrange
                              : BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(
                      title: 'ชือ ${sickmodels[i].name}',
                      snippet: 'ระดับ ${sickmodels[i].level}'),
                ));
              });
            }
          }
        }
      });
      FirebaseFirestore.instance
          .collection('location')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationModel model = LocationModel.fromMap(item.data());
          print('locationModel ====>>>${locationModel.length}');
          setState(() {
            locationModel.add(model);
            print('locationModel ==${locationModel.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < locationModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  markerId: MarkerId(locationModel[i].location),
                  position: LatLng(locationModel[i].lat, locationModel[i].lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      locationModel[i].location == 'โรงเรียน'
                          ? BitmapDescriptor.hueGreen
                          : locationModel[i].location == 'ร้านค้าใกล้บ้าน'
                              ? BitmapDescriptor.hueAzure
                              : locationModel[i].location == 'สถานณีอนามัย'
                                  ? BitmapDescriptor.hueBlue
                                  : locationModel[i].location ==
                                          'องค์การบริหารส่วนตำบล'
                                      ? BitmapDescriptor.hueViolet
                                      : locationModel[i].location == 'โรงพยาบาล'
                                          ? BitmapDescriptor.hueRose
                                          : BitmapDescriptor.hueCyan),
                  infoWindow: InfoWindow(
                    title: 'สถานที่ ${locationModel[i].location}',
                  ),
                ));
              });
            }
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readAlldata();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    // _createMarkerImageFromAsset(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          _buildPopupMenu(),
        ],
        title: Center(
          child: Text(
            'แผนที่',
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
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.home),
        label: const Text('บันทึกสถานที่สำคัญ'),
        backgroundColor: Color(0xfff29a94),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AppLocation()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<Choice>(itemBuilder: (context) {
      return choices.map((Choice choice) {
        return PopupMenuItem<Choice>(
          value: choice,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                choice.icon!,
                color: choice.color!,
              ),
              SizedBox(
                width: 20,
              ),
              Text(choice.title!),
            ],
          ),
        );
      }).toList();
    });
  }

  Widget _buildGoogleMap(
    BuildContext context,
  ) {
    return sickmodels.length == 0
        ? ShowProgress()
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(13.730583745661047, 100.4742379568907),
                zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
          );
  }
}
