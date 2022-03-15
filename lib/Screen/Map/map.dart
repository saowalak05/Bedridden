import 'dart:async';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set(); //markers for google map

  List<SickModel> sickmodels = [];



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
                  infoWindow: InfoWindow(
                      title: 'พิกัด ${sickmodels[i].name}',
                      snippet:
                          'Lat = ${sickmodels[i].lat}  lng = ${sickmodels[i].lng}'),
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'Map',
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
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
        ],
      ),
    );
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
