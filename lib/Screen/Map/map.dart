import 'dart:async';
import 'package:bedridden/models/sick_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  List<SickModel> sickmodels = [];

  @override
  void initState() {
    super.initState();
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
          // _buildGoogleMap(context),
        ],
      ),
    );
  

  // Widget boxes(String _image, double lat, double long, String restaurantName) {
  //   return GestureDetector(
  //     onTap: () {
  //       _gotoLocation(lat, long);
  //     },
  //     child: Container(
  //       child: new FittedBox(
  //         child: Material(
  //             color: Colors.white,
  //             elevation: 14.0,
  //             borderRadius: BorderRadius.circular(24.0),
  //             shadowColor: Color(0xffdfad98),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Container(
  //                   width: 180,
  //                   height: 200,
  //                   child: ClipRRect(
  //                     borderRadius: new BorderRadius.circular(24.0),
  //                     child: Image(
  //                       fit: BoxFit.fill,
  //                       image: NetworkImage(_image),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       ),
  //     ),
  //   );
  }

  // Set<Marker> setMarker() => <Marker>{
  //       Marker(
  //         markerId: MarkerId('id'),
  //         position: LatLng(lat!, lng!),
  //         infoWindow: InfoWindow(
  //             title: 'พิกัด ' + '$nameSick', snippet: 'Lat = $lat, lng = $lng'),
  //       ),
  //     }.toSet();

  // Widget _buildGoogleMap(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     child: GoogleMap(
  //       mapType: MapType.normal,
  //       initialCameraPosition:
  //           CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
  //       onMapCreated: (GoogleMapController controller) {
  //         _controller.complete(controller);
  //       },
  //       markers: {},
  //     ),
  //   );
  // }

  // Future<void> _gotoLocation(double lat, double long) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(lat, long),
  //     zoom: 15,
  //     tilt: 50.0,
  //     bearing: 45.0,
  //   )));
  // }
}
