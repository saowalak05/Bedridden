import 'dart:io';

import 'package:bedridden/utility/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

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

  String imageadd = 'assets/images/image_mountain_photo.png';

  String? typeFacilities;

  // List<Widget> widgets = [];
  // int index = 0;

  List<File?> files = [];
  File? file;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   widgets.add(
  //     buildFormOtheraccommodation(),
  //   );
  //   widgets.add(Text('data'));
  //   widgets.add(Text('data'));
  //   widgets.add(Text('data'));
  //    widgets.add(Text('data'));
  // }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
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
        body: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Form(
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: [
                        buildTitle4(),
                        // buildaccommodation(),
                        // widgets[index],
                        // buildtypeHouse(),
                        // widgets[index],
                        // buildHomeEnvironment(),
                        // widgets[index],
                        // buildHousingSafety(),
                        // widgets[index],
                        // buildFacilities(),
                        // widgets[index],
                        buildImage(constraints),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.75,
                              child: MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  'เพิ่มรูปภาพ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: const Color(0xffffede5),
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                color: const Color(0xffdfad98),
                              ),
                            ),
                          ],
                        ),
                        buildNext4(context),
                      ],
                    ),
                  ),
                )));
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceTmageDialog(int index) async {
    print('Click Form index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset("assets/images/bedridden.png"),
          title: Text('กรุณาเลือกแหล่งภาพ ${index + 1} ?'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processImagePicker(ImageSource.camera, index);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processImagePicker(ImageSource.gallery, index);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child: file == null ? Image.asset(imageadd) : Image.file(file!),
        ),
        Container(
          width: constraints.maxWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(0),
                  child: files[0] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(1),
                  child: files[1] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(2),
                  child: files[2] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceTmageDialog(3),
                  child: files[3] == null
                      ? Image.asset(imageadd)
                      : Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String;
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
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String;
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
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                 typeHouse = value as String;
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
            value:1,
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String;
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
            value: 'อื่น ๆ',
            groupValue: typeHouse,
            onChanged: (value) {
              setState(
                () {
                  typeHouse = value as String;
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
