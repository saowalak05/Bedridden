import 'package:flutter/material.dart';

class Mystyle extends StatefulWidget {
  const Mystyle({ Key? key }) : super(key: key);

  @override
  _MystyleState createState() => _MystyleState();
}

class _MystyleState extends State<Mystyle> {
final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

  @override
  Widget build(BuildContext context) {
    return Container(


      
    );
  }
}