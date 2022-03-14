import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTast extends StatefulWidget {
  const MapTast({Key? key}) : super(key: key);

  @override
  State<MapTast> createState() => _MapTastState();
}

class _MapTastState extends State<MapTast> {
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
      body: FireMap(),
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {
  @override
  build(context) {
    return Stack(
      children: <Widget>[],
    );
  }
}
