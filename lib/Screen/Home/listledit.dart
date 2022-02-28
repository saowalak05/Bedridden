import 'package:bedridden/models/sick_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LitlEdit extends StatefulWidget {
  final String idcard;
  const LitlEdit({
    Key? key,
    required this.idcard,
  }) : super(key: key);

  @override
  _LitlEditState createState() => _LitlEditState();
}

//sick
String? addressSick;
String? bondSick;
String? idCardSick;
String? latSick;
String? levelSick;
String? lngSick;
String? nameSick;
String? nationalitySick;
String? patientoccupationSick;
String? phoneSick;
String? raceSick;
String? religionSick;
String? talentSick;
String? typeSexSick;
String? typeStatusSick;
String? typeeducationlevelSick;
String? typepositionSick;
String? urlImageSick;
//Health
String? diseaseHealth;
String? foodsupplementHealth;
String? groupAHealth;
String? groupBHealth;
String? herbHealth;
String? medicineHealth;
// environment
String? accommodationenvironment;
String? typeHomeEnvironmentenvironment;
String? typeHouseenvironment;
String? typeHousingSafetyenvironment;
String? typefacilitiesenvironment;
String? urlenvironmentImageenvironment;
//Family
String? familynameoneFamily;
String? familynamethreeFamily;
String? familynametwoFamily;
String? familyrelationshiponeFamily;
String? familyrelationshipthreeFamily;
String? familyrelationshiptwoFamily;
String? occupationoneFamily;
String? occupationthreeFamily;
String? occupationtwoFamily;

class _LitlEditState extends State<LitlEdit> {
  List<SickModel> sickmodels = [];

  @override
  void initState() {
    super.initState();
    readAllSick();
  }

  Future<Null> readAllSick() async {
    if (sickmodels.length != 0) {
      sickmodels.clear();
    }

    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance
          .collection('sick')
          .doc(widget.idcard)
          .snapshots()
          .listen((event) {
        DateTime dateTime = event['bond'].toDate();
        DateFormat dateFormat = DateFormat('dd-MMMM-yyyy', 'th');
        String bondStr = dateFormat.format(dateTime);
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            addressSick = event['address'];
            bondSick = bondStr;
            idCardSick = event['idCard'];
            latSick = event['lat'].toString();
            lngSick = event['lng'].toString();
            levelSick = event['level'];
            nameSick = event['name'];
            nationalitySick = event['nationality'];
            patientoccupationSick = event['patientoccupation'];
            phoneSick = event['phone'];
            raceSick = event['race'];
            religionSick = event['religion'];
            talentSick = event['talent'];
            typeSexSick = event['typeSex'];
            typeStatusSick = event['typeStatus'];
            typeeducationlevelSick = event['typeeducation_level'].toString();
            typepositionSick = event['typeposition'].toString();
            urlImageSick = event['urlImage'];
          });
        });
      });
      FirebaseFirestore.instance
          .collection('Health')
          .doc(widget.idcard)
          .snapshots()
          .listen((event) {
        print(widget.idcard);
        print(event['medicine']);
      });
      FirebaseFirestore.instance
          .collection('environment')
          .doc('${widget.idcard}')
          .snapshots()
          .listen((event) {});

      FirebaseFirestore.instance
          .collection('Family')
          .doc('${widget.idcard}')
          .snapshots()
          .listen((event) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ประวัติผู้ป่วย',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "ลบข้อมูล  ",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14, color: Colors.red),
            ),
          ),
        ],
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0))),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage('$urlImageSick'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ชื่อ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$nameSick',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ระดับ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$levelSick',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ส่วนที่ 1 ข้อมูลของผู้ป่วย',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                MaterialButton(
                  minWidth: 50,
                  height: 30,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xffffede5),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "แก้ไข",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  color: const Color(0xffdfad98),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('เลขบัตรประจำตัวประชาชน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$idCardSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('วัน/เดือน/ปีเกิด',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$bondSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('เพศ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeSexSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สถานะ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeStatusSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ที่อยู่ปัจจุบัน',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$addressSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('พิกัดที่อยู่',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Text('lat : ', style: TextStyle(fontSize: 16)),
                Text('$latSick ', style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text('lng : ', style: TextStyle(fontSize: 16)),
                Text('$lngSick', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 10),
            Text('เบอร์โทรศัพท์',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$phoneSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('เชื้อชาติ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$raceSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('สัญชาติ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$nationalitySick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ศาสนา',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$religionSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ระดับการศึกษา',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typeeducationlevelSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ก่อนป่วยติดเตียงผู้ป่วยทำอาชีพ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$patientoccupationSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ความสามารถพิเศษ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$talentSick', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('ฐานะของผู้และครอบครัว',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('$typepositionSick', style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ข้อมูลส่วนที่ 2 ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                MaterialButton(
                  minWidth: 50,
                  height: 30,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xffffede5),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "แก้ไข",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  color: const Color(0xffdfad98),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ข้อมูลส่วนที่ 3 ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                MaterialButton(
                  minWidth: 50,
                  height: 30,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xffffede5),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "แก้ไข",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  color: const Color(0xffdfad98),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ข้อมูลส่วนที่ 4 ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                MaterialButton(
                  minWidth: 50,
                  height: 30,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xffffede5),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "แก้ไข",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  color: const Color(0xffdfad98),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
