import 'package:bedridden/models/location_model.dart';
import 'package:bedridden/utility/dialog.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppLocation extends StatefulWidget {
  const AppLocation({Key? key}) : super(key: key);

  @override
  State<AppLocation> createState() => _AppLocationState();
}

class _AppLocationState extends State<AppLocation> {
  String? typelocation;

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
      LocationModel model = LocationModel(
        location: typelocation!,
        lat: lat!,
        lng: lng!,
      );

      await FirebaseFirestore.instance
          .collection('location')
          .doc()
          .set(model.toMap())
          .then((value) => normalDialog(context, 'บันทึกข้อมูลสำเร็จ'));
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
        leading: Container(),
        title: Text(
          'เพิ่ม สถานที่สำคัญ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
        height: 200,
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
              if (typelocation == null) {
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
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'ร้านค้าใกล้บ้าน',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'ร้านค้าใกล้บ้าน',
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'สถานณีอนามัย',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'สถานณีอนามัย',
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'องค์การบริหารส่วนตำบล',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'องค์การบริหารส่วนตำบล',
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'โรงพยาบาล',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'โรงพยาบาล',
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 160,
              child: RadioListTile(
                title: const Text(
                  'วัด',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'วัด',
                groupValue: typelocation,
                onChanged: (value) {
                  setState(
                    () {
                      typelocation = value as String?;
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