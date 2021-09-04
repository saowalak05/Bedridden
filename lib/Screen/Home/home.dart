import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(50.0, 50.0))),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  List<Widget> WidgetSearch(BuildContext context) {
    return <Widget>[
            SizedBox(
                    height: 20,
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextField(
                  // controller: TextEditingController(),
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                      hintText: "Search ",
                      hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                      suffixIcon: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(Icons.search),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
          ];
  }
}
