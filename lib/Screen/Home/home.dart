import 'package:bedridden/Screen/Home/homenameall/homelistnameall.dart';
import 'package:bedridden/Screen/Home/homenameall/homelistnamebedridden1.dart';
import 'package:bedridden/Screen/Home/homenamelevel1all/homelistnamelevel1.dart';
import 'package:bedridden/Screen/Home/homenamelevel1all/homelistnamelevel1_1.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);

  get padding => null;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            children: [
              buildSearch(), //'ค้นหารายชื่อผู้ป่วยติดเตียง'
              buildtTtleListNameAllBedridden(), //'รายชื่อผู้ป่วยติดเตียง,โชว์ทั้งหมด'
              buildtListNameAllBedridden(), //'รายชื่อผู้ป่วยติดเตียง'
              buildtTtleListNameAllBedriddenLevel1(), //'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1,โชว์ทั้งหมด'
              buildtListNameAllBedriddenLevel1(),//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1'
            ],
          ),
        ),
      ),
    );
  }
//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1'
  Container buildtListNameAllBedriddenLevel1() {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          homelistnamelevel1(),
          homelistnamelevel1_1(),
        ],
      ),
    );
  }

//'รายชื่อผู้ป่วยติดเตียง ระดับที่ 1,โชว์ทั้งหมด'
  Row buildtTtleListNameAllBedriddenLevel1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย ระดับที่ 1",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => LoginPage()),
              // );
            },
            child: Text(
              "ทั้งหมด",
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    );
  }

//'รายชื่อผู้ป่วยติดเตียง'
  Container buildtListNameAllBedridden() {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [homelistnameall(), homelistnamebedridden1()],
      ),
    );
  }

//'รายชื่อผู้ป่วยติดเตียง,โชว์ทั้งหมด'
  Row buildtTtleListNameAllBedridden() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "รายชื่อผู้ป่วย",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.black87),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => LoginPage()),
              // );
            },
            child: Text(
              "ทั้งหมด",
              style: TextStyle(
                color: Colors.black54,
              ),
            )),
      ],
    );
  }

//'ค้นหารายชื่อผู้ป่วยติดเตียง'
  Widget buildSearch() {
    return Center(
      child: Column(
        children: [
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
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(Icons.search),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
