import 'dart:async';
import 'package:bedridden/Screen/Map/addHEL.dart';
import 'package:bedridden/Screen/Map/addHOT.dart';
import 'package:bedridden/Screen/Map/addSAO.dart';
import 'package:bedridden/Screen/Map/addSCH.dart';
import 'package:bedridden/Screen/Map/addST.dart';
import 'package:bedridden/Screen/Map/addlocation.dart';
import 'package:bedridden/models/location_model.dart';
import 'package:bedridden/models/location_model_HEL.dart';
import 'package:bedridden/models/location_model_HOT.dart';
import 'package:bedridden/models/location_model_SAO.dart';
import 'package:bedridden/models/location_model_SCH.dart';
import 'package:bedridden/models/location_model_ST.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../Addbedridden/add.dart';
import 'calculate.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class Choice {
  final String? title;
  final IconData? icon;
  final Color? color;
  const Choice({this.title, this.icon, this.color});
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'ระดับที่1', icon: Icons.circle, color: Colors.yellow),
  const Choice(title: 'ระดับที่2', icon: Icons.circle, color: Colors.orange),
  const Choice(title: 'ระดับที่3', icon: Icons.circle, color: Colors.red),
];

class Mappage extends StatefulWidget {
  @override
  MappageState createState() => MappageState();
}

class MappageState extends State<Mappage> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = new Set(); //markers for google map

  List<SickModel> sickmodels = [];
  List<LocationModel> locationModel = [];
  List<LocationHELModel> locationHELModel = [];
  List<LocationSCHModel> locationSCHModel = [];
  List<LocationSAOModel> locationSAOModel = [];
  List<LocationHOTModel> locationHOTModel = [];
  List<LocationSTModel> locationSTModel = [];

  Future<Null> readAlldata() async {
    setState(() {
      if (sickmodels.length != 0) {
        sickmodels.clear();
      }
    });

    final Uint8List imgurltemple =
        await getBytesFromAsset('assets/images/temple.png', 80);
    final Uint8List imgurlsupermarket =
        await getBytesFromAsset('assets/images/shoppingone.png', 80);
    final Uint8List imgurlschool =
        await getBytesFromAsset('assets/images/schoolone.png', 80);
    final Uint8List imgurlhospital =
        await getBytesFromAsset('assets/images/hospitalone.png', 80);
    final Uint8List imgurlOrganization =
        await getBytesFromAsset('assets/images/Organizationone.png', 80);
    final Uint8List imgurlsanitation =
        await getBytesFromAsset('assets/images/sanitationone.png', 80);

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
                  markerId: MarkerId(DateTime.now().toString()),
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
                print(locationModel.length);
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(locationModel[i].locationTEM),
                  position: LatLng(locationModel[i].lat, locationModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'วัด',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurltemple),
                  //Icon for Marker
                ));
              });
            }
          }
        }
      });

      FirebaseFirestore.instance
          .collection('locationST')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationSTModel model = LocationSTModel.fromMap(item.data());
          print('locationSTModel ====>>>${locationSTModel.length}');
          setState(() {
            locationSTModel.add(model);
            print('locationSTModel ==${locationSTModel.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < locationSTModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(DateTime.now().toString()),
                  position:
                      LatLng(locationSTModel[i].lat, locationSTModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'ร้านค้า',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurlsupermarket),
                  //Icon for Marker
                ));
              });
            }
          }
        }
      });

      FirebaseFirestore.instance
          .collection('locationSCH')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationSCHModel model = LocationSCHModel.fromMap(item.data());
          print('locationSCHModel ====>>>${locationSCHModel.length}');
          setState(() {
            locationSCHModel.add(model);
            print('locationSCHModel ==${locationSCHModel.length}');
          });
          if (event.docs.isNotEmpty) {
            print("askdjalksjdalksjdalksjdlaksjdlkasd");
            for (var i = 0; i < locationSCHModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(DateTime.now().toString()),
                  position:
                      LatLng(locationSCHModel[i].lat, locationSCHModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'โรงเรียน',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurlschool),
                  //Icon for Marker
                ));
              });
            }
          }
        }
      });

      FirebaseFirestore.instance
          .collection('locationSAO')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationSAOModel model = LocationSAOModel.fromMap(item.data());
          print('locationSAOModel ====>>>${locationSAOModel.length}');
          setState(() {
            locationSAOModel.add(model);
            print('locationSAOModel ==${locationSAOModel.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < locationSAOModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(DateTime.now().toString()),
                  position:
                      LatLng(locationSAOModel[i].lat, locationSAOModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'องค์การบริหารส่วนตำบล',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurlOrganization),
                  //Icon for Marker
                ));
              });
            }
          }
        }
      });

      FirebaseFirestore.instance
          .collection('locationHEL')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationHELModel model = LocationHELModel.fromMap(item.data());
          print('locationHELModel ====>>>${locationHELModel.length}');
          setState(() {
            locationHELModel.add(model);
            print('locationHELModel ==${locationHELModel.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < locationHELModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(DateTime.now().toString()),
                  position:
                      LatLng(locationHELModel[i].lat, locationHELModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'สถานีอนามัย',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurlsanitation),
                  //Icon for Marker
                ));
              });
            }
          }
        }
      });

      FirebaseFirestore.instance
          .collection('locationHOT')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          LocationHOTModel model = LocationHOTModel.fromMap(item.data());
          print('locationHOTModel ====>>>${locationHOTModel.length}');
          setState(() {
            locationHOTModel.add(model);
            print('locationHELModel ==${locationHOTModel.length}');
          });
          if (event.docs.isNotEmpty) {
            for (var i = 0; i < locationHOTModel.length; i++) {
              setState(() {
                markers.add(Marker(
                  //add start location marker
                  markerId: MarkerId(DateTime.now().toString()),
                  position:
                      LatLng(locationHOTModel[i].lat, locationHOTModel[i].lng),
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'โรงพยาบาล',
                    // snippet: 'Car Marker',
                  ),
                  icon: BitmapDescriptor.fromBytes(imgurlhospital),
                  //Icon for Marker
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SpeedDial(
                    child: const Icon(Icons.add_location),
                    speedDialChildren: <SpeedDialChild>[
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'โรงเรียน',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSCH(),
                              ));
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'ร้านค้าใกล้บ้าน',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddST(),
                              ));
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'สถานีอนามัย',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddHEL(),
                              ));
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'องค์การบริหารส่วนตำบล',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSAO(),
                              ));
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'โรงพยาบาล',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddHOT(),
                              ));
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.add_location),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 231, 172, 11),
                        label: 'วัด',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppLocation(),
                              ));
                        },
                      ),
                    ],
                    // closedForegroundColor: const Color(0xffdfad98),
                    // openForegroundColor: const Color(0xffdfad98),
                    closedBackgroundColor: const Color(0xfff29a94),
                    openBackgroundColor: Color.fromARGB(255, 255, 143, 95),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalculatePage()));
                    },
                    backgroundColor: Color(0xfff29a94),
                    child: const Icon(Icons.calculate),
                  ),
                ),
              ],
            ),
          )
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   elevation: 4.0,
      //   icon: const Icon(Icons.home),
      //   label: const Text('บันทึกสถานที่สำคัญ'),
      //   backgroundColor: Color(0xfff29a94),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AppLocation()));
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(19.030864682775583, 99.92628236822989), zoom: 16),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
    );
  }
}
