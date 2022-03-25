import 'dart:io';
import 'package:bedridden/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        title: Icon(
          Icons.warning_rounded,
          color: Color.fromARGB(255, 253, 17, 0),
          size: 60,
        ),
        subtitle: Text(string),
      ),
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
      ],
    ),
  );
}

class MyDialog {
  Future<Null> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: 'assets/images/bedridden.png'),
          title: Text('Location Service ปิดอยู่'),
          subtitle: Text('กรุณาเปิด Location Service'),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                // Navigator.pop(context);
                await Geolocator.openLocationSettings();
                exit(0);
              },
              child: Text('OK'))
        ],
      ),
    );
  }
}
