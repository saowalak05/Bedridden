import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class add extends StatefulWidget {
  const add({
    Key? key,
  }) : super(key: key);

  @override
  _addState createState() => _addState();
}

String? _typesex;
String? _typestatus;

class _addState extends State<add> {
  late DateTime pickedDate;
  File? _imageFile;
  final _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final IconThemeData data;
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
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildSaveBedridden(), //'บันทึก'
          buildBedriddenTitle(), //'ข้อมูลผู้ป่วย'
          buildImageBedridden(context), //'รูปภาพ'
          buildNameNumBersexBedridden(), //'ชื่อ-นามสุกม,เลขบัตรประจำตัวประชาชน,เพศ'
          buildAddressPhonenumberBedridden(), //'ที่อยู่เ,บอร์โทร์'
          buildDatePickerBedridden(), //'วัน/เดือน/ปีเกิด'
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'สถานภาพสมรส',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),

          //"สถานภาพสมรส"

          RadioListTile(
            title: const Text('โสด'),
            value: 'single',
            groupValue: _typestatus,
            onChanged: (value) {
              setState(
                () {
                  value = _typestatus;
                },
              );
            },
          ),
          RadioListTile(
            title: const Text('สมรส'),
            value: 'marital',
            groupValue: _typestatus,
            onChanged: (value) {
              setState(
                () {
                  value = _typestatus;
                },
              );
            },
          ),
          RadioListTile(
            title: const Text('หม้าย'),
            value: 'widow',
            groupValue: _typestatus,
            onChanged: (value) {
              setState(
                () {
                  value = _typestatus;
                },
              );
            },
          ),
          RadioListTile(
            title: const Text('อย่าร้าง'),
            value: 'divorce',
            groupValue: _typestatus,
            onChanged: (value) {
              setState(
                () {
                  value = _typestatus;
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Column buildDatePickerBedridden() {
    return Column(
      children: [
        ListTile(
          title: Text(
              "วัน/เดือน/ปีเกิด : ${pickedDate.day} , ${pickedDate.month} , ${pickedDate.year}"),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: _pickDate,
        ),
      ],
    );
  }

  Column buildAddressPhonenumberBedridden() {
    return Column(
      children: [
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ที่อยู่ปัจจุบัน',
            labelText: 'ที่อยู่ปัจจุบัน *',
            fillColor: const Color(0xfff7e4db),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'เบอร์โทรศัพท์',
            labelText: 'เบอร์โทรศัพท์ *',
            fillColor: const Color(0xfff7e4db),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Column buildNameNumBersexBedridden() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 16.0),
        // "ชื่อ-นามสุกล" form.
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'ชื่อ-นามสุกล',
            labelText: 'ชื่อ-นามสุกล *',
            fillColor: const Color(0xfff7e4db),
          ),
        ),
        const SizedBox(height: 16.0),
        // "เลขบัตรประจำตัวชาชน" form.
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: 'เลขบัตรประจำตัวชาชน',
            labelText: 'เลขบัตรประจำตัวชาชน *',
            fillColor: const Color(0xfff7e4db),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        Container(
          child: Row(
            children: <Widget>[
              Text('เพศ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),

        //"เพศ"

        RadioListTile(
          title: const Text('ชาย'),
          value: 'man',
          groupValue: _typesex,
          onChanged: (value) {
            setState(
              () {
                value = _typesex;
              },
            );
          },
        ),
        RadioListTile(
          title: const Text('หญิง'),
          value: 'female',
          groupValue: _typesex,
          onChanged: (value) {
            setState(
              () {
                value = _typesex;
              },
            );
          },
        ),
      ],
    );
  }

  Container buildImageBedridden(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
        color: const Color(0xffdfad98),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets\images\image_icon.png"),
        ),
      ),
      child: Row(
        children: [
          ButtonBar(),
          // if (this._imageFile == null)
          //   const Placeholder()
          // else
          //   Image.file(this._imageFile!),
        ],
      ),
    );
  }

  Widget buildBedriddenTitle() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'ข้อมูลข้องผู้ป่วย',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.photo_camera),
          //   onPressed: () async => _pickImageFromCamera(),
          //   tooltip: 'Shoot picture',
          // ),
          // IconButton(
          //   icon: const Icon(Icons.photo),
          //   onPressed: () async => _pickImageFromGallery(),
          //   tooltip: 'Pick from gallery',
          // ),
        ],
      ),
    );
  }

  MaterialButton buildSaveBedridden() {
    return MaterialButton(
      padding: EdgeInsets.all(8),
      minWidth: 0.50,
      height: 30,
      onPressed: () {},
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
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (date != null)
      setState(
        () {
          pickedDate = date;
        },
      );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(
        () => this._imageFile = File(pickedFile.path),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(
        () => this._imageFile = File(pickedFile.path),
      );
    }
  }
}
