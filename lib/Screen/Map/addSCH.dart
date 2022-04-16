import 'package:bedridden/Screen/my_service.dart';
import 'package:bedridden/models/location_model_SCH.dart';
import 'package:bedridden/models/location_model_ST.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddSCH extends StatefulWidget {
  const AddSCH({Key? key}) : super(key: key);

  @override
  State<AddSCH> createState() => _AddSCHState();
}

class _AddSCHState extends State<AddSCH> {
  String? typelocationSCH;

  double? lat;
  double? lng;

  Future<Null> checkPermission() async {
    bool locationService;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLang
          findLatLng();
        }
      } else {
        if (permission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วยคะ');
    }
  }

  Future<Null> findLatLng() async {
    Position? position = await findPostion();
    if (mounted) {
      setState(() {
        lat = position!.latitude;
        lng = position.longitude;
        print('lat = $lat, lng = $lng');
      });
    }
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<Null> proccessUplodlocation() async {
    await Firebase.initializeApp().then((value) async {
      LocationSCHModel model = LocationSCHModel(
        locationSCH: typelocationSCH!,
        lat: lat!,
        lng: lng!,
      );

      await FirebaseFirestore.instance
          .collection('locationSCH')
          .doc()
          .set(model.toMap())
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyService())));
    });
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(30.0, 30.0),
          ),
        ),
        title: Center(
          child: Text(
            'เพิ่มสถานที่สำคัญ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          child: ListView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            children: [
              groupTypeeducation(), //'ระดับการศึกษา'
              buildMap(),
              buildSaveBedridden(), //'บันทึก'
            ],
          ),
        ),
      ),
    );
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow:
              InfoWindow(title: 'พิกัด', snippet: 'Lat = $lat, lng = $lng'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        margin: EdgeInsets.symmetric(vertical: 16),
        width: 200,
        height: 330,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                onTap: (latLng) {
                  setState(() {
                    lat = latLng.latitude;
                    lng = latLng.longitude;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
      );

  Container buildSaveBedridden() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              if (typelocationSCH == null) {
                normalDialog(context, 'กรุณาเลือก สถานที่');
              } else {
                proccessUplodlocation();
              }
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: const Color(0xffffede5),
                ),
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              "บันทึก",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            color: const Color(0xffdfad98),
          ),
        ],
      ),
    );
  }

  Column groupTypeeducation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'สถานที่สำคัญ :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'โรงเรียน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'โรงเรียน',
                groupValue: typelocationSCH,
                onChanged: (value) {
                  setState(
                    () {
                      typelocationSCH = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
