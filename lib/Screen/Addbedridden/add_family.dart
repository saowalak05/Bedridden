import 'package:flutter/material.dart';

class Addfamily extends StatefulWidget {
  const Addfamily({Key? key}) : super(key: key);

  @override
  _AddfamilyState createState() => _AddfamilyState();
}

class _AddfamilyState extends State<Addfamily> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  

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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            child: ListView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              children: [
                Container(
                  child: Center(
                    child: Text(
                      ' ส่วนที่ 2 ข้อมูลความสัมพันธ์กับสมาชิกในครอบครัว ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'ชื่อ-สกุล สมาชิกในครอบครัว :',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '1.ชื่อ-สกุล',
                        labelText: '1.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '2.ชื่อ-สกุล',
                        labelText: '2.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '3.ชื่อ-สกุล',
                        labelText: '3.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '4.ชื่อ-สกุล',
                        labelText: '4.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '5.ชื่อ-สกุล',
                        labelText: '5.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ชื่อ-สกุล';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: '6.ชื่อ-สกุล',
                        labelText: '6.ชื่อ-สกุล *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก ความสัมพันธ์กับผู้ป่วย';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'ความสัมพันธ์กับผู้ป่วย',
                        labelText: 'ความสัมพันธ์กับผู้ป่วย ระบุ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก อาชีพ';
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'อาชีพ',
                        labelText: 'อาชีพ *',
                        fillColor: const Color(0xfff7e4db),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ));
  }
}
