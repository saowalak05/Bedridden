import 'package:flutter/material.dart';

class Addenvironment extends StatefulWidget {
  const Addenvironment({Key? key}) : super(key: key);

  @override
  _AddenvironmentState createState() => _AddenvironmentState();
}

class _AddenvironmentState extends State<Addenvironment> {
  final formkey = GlobalKey<FormState>();
  TextEditingController OtheraccommodationController = TextEditingController();

  String? accommodation;
  String? typeHouse;
  String? typeHomeEnvironment;
  String? typeHousingSafety;
  String? typeFacilities;

  List<Widget> widgetsresidence_status = [];
  int indexresidence_status = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetsresidence_status.add(
      buildFormOtheraccommodation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffdfad98),
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(50.0, 50.0),
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
                buildTitle4(),
                buildaccommodation(),
                widgetsresidence_status[indexresidence_status],
                buildtypeHouse(),
                widgetsresidence_status[indexresidence_status],
                buildHomeEnvironment(),
                widgetsresidence_status[indexresidence_status],
                buildHousingSafety(),
                widgetsresidence_status[indexresidence_status],
                buildFacilities(),
                widgetsresidence_status[indexresidence_status],
                buildNext4(context),
              ],
            ),
          ),
        ));
  }

  Column buildNext4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addenvironment()));
          },
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: const Color(0xffffede5),
              ),
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            "หน้าถัดไป",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          color: const Color(0xffdfad98),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  Column buildFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),

        Text('มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้ :',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),

        //"มีสิ่งอำนวยความสะดวกให้ผู้ป่วยสามารถดำรงชีวิตในบ้านได้"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('ไม่มี'),
                value: 'ไม่มี',
                groupValue: typeFacilities,
                onChanged: (value) {
                  setState(
                    () {
                      typeFacilities = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text(
                'มี ได้แก่ (ราวจับในบ้าน ราวจับในห้องน้ำ ทางลาดของรถเซ็น อื่น ๆ ระบุ)'),
            value: 0,
            groupValue: indexresidence_status,
            onChanged: (value) {
              setState(
                () {
                  indexresidence_status = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildHousingSafety() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(' ความปลอดภัยของที่อยู่อาศัย :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('(สำรวจละเอียดโดยเฉพาะบริเวณที่ผู้ป่วยอยู่และใช้งาน)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ))
            ],
          ),
        ),

        //"ความปลอดภัยของที่อยู่อาศัย"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('ปลอดภัย'),
                value: 'ปลอดภัย',
                groupValue: typeHousingSafety,
                onChanged: (value) {
                  setState(
                    () {
                      typeHousingSafety = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ไม่ปลอดภัย อธิบายที่สังเกตได้'),
            value: 0,
            groupValue: indexresidence_status,
            onChanged: (value) {
              setState(
                () {
                  indexresidence_status = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildHomeEnvironment() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(' สภาพสิ่งแวดล้อมในบ้าน :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"สภาพสิ่งแวดล้อมในบ้าน"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('สะอาด'),
                value: 'สะอาด',
                groupValue: typeHomeEnvironment,
                onChanged: (value) {
                  setState(
                    () {
                      typeHomeEnvironment = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('สะอาดปานกลาง'),
                value: 'สะอาดปานกลาง',
                groupValue: typeHouse,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouse = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ไม่สะอาด อธิบายที่สังเกตได้'),
            value: 0,
            groupValue: indexresidence_status,
            onChanged: (value) {
              setState(
                () {
                  indexresidence_status = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildtypeHouse() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('ประเภทบ้าน :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"ประเภทบ้าน"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านชั้นเดียว'),
                value: 'บ้านชั้นเดียว',
                groupValue: typeHouse,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouse = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านสองชั้นขึ้นไป'),
                value: 'บ้านสองชั้นขึ้นไป',
                groupValue: typeHouse,
                onChanged: (value) {
                  setState(
                    () {
                      typeHouse = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('ตึกแถว ห้องแถว'),
            value: 'ตึกแถว ห้องแถว',
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String?;
                },
              );
            },
          ),
        ),

        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('อื่น ๆ (เช่น กระต๊อบ ชนำ เป็นต้น) ระบุ'),
            value: 0,
            groupValue: indexresidence_status,
            onChanged: (value) {
              setState(
                () {
                  indexresidence_status = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildaccommodation() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('สถานะของที่พักอาศัย :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"ที่พักอาศัย"

        Row(
          children: [
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านพ่อแม่'),
                value: 'บ้านพ่อแม่',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านตนเอง'),
                value: 'บ้านตนเอง',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String?;
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
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านญาติ'),
                value: 'บ้านญาติ',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String?;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 170,
              child: RadioListTile(
                title: const Text('บ้านเช่า'),
                value: 'บ้านเช่า',
                groupValue: accommodation,
                onChanged: (value) {
                  setState(
                    () {
                      accommodation = value as String?;
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Container(
          width: 400,
          child: RadioListTile(
            title: const Text('อื่น ๆ'),
            value: 0,
            groupValue: indexresidence_status,
            onChanged: (value) {
              setState(
                () {
                  indexresidence_status = value as int;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildTitle4() {
    return Container(
      child: Center(
        child: Text(
          'ส่วนที่ 3 ข้อมูลสภาพแวดล้อม ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Column buildFormOtheraccommodation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                ' อื่น ๆ :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอก ระบุที่พักอาศัยอื่น ๆ';
            } else {
              return null;
            }
          },
          controller: OtheraccommodationController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ระบุ',
            labelText: 'ระบุ *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
      ],
    );
  }
}
