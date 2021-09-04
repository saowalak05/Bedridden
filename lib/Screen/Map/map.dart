import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class map extends StatelessWidget {
  const map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(50.0, 50.0))),     
      ),
      body: showmap(),
    );
  }
}

Container showmap() {
  return Container(
      child: GoogleMap(
    mapType: MapType.normal,
    initialCameraPosition: CameraPosition(
      target: LatLng(19.030865, 99.925963),
      zoom: 16,
    ),
    onMapCreated: (GoogleMapController controller) {},
  ));
}
