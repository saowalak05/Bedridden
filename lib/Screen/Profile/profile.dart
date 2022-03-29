import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bedridden/utility/dialog.dart';
import 'package:bedridden/widgets/show_progess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController userNameController = TextEditingController();

  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  bool load = true;
  String? email;
  String? name;
  String? surname;
  bool changeDisplayName = true; // true => ยังไม่มีการเปลี่ยน DisplayName
  String? urlImage;
  File? file;

  @override
  void initState() {
    super.initState();
    findCurrentUser();
  }

  Future<Null> findCurrentUser() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          userNameController.text = event!.displayName!;
          email = event.email;
          name = event.email;
          surname = event.email;
          urlImage = event.photoURL;
          print('### urlImage = $urlImage');
          load = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0))),
      ),
      body: load ? ShowProgress() : buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                // padding: EdgeInsets.all(50.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                child: file != null
                    ? circleFile()
                    : urlImage != null
                        ? circleNetwork()
                        : circleAsset(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.small(
                    backgroundColor: Color(0xffdfad98),
                    onPressed: () => confirmImageDialog(),
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton.small(
                    backgroundColor: Color(0xffdfad98),
                    onPressed: () {
                      if (file == null) {
                        normalDialog(context, 'กรุณาใส่ภาพ');
                      } else {
                        processChangeImageProfile();
                      }
                    },
                    child: Icon(
                      Icons.save,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                        onChanged: (value) {
                          changeDisplayName = false;
                        },
                        controller: userNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          hintText: "username",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 20,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (changeDisplayName) {
                                normalDialog(
                                    context, 'ยังไม่มีการเปลี่ยนแปลง ?');
                              } else {
                                processChangeDisplayName();
                              }
                            },
                            icon: const Icon(Icons.save),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: Text(email!),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundedLoadingButton(
                      color: Color(0xffdfad98),
                      successColor: Color(0xffdfad98),
                      controller: _btnController2,
                      onPressed: () async {
                        await Firebase.initializeApp().then((value) async {
                          await FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/LoginPage', (route) => false));
                        });
                      },
                      valueColor: Colors.white,
                      borderRadius: 10,
                      child: Text('''ออกจากระบบ''',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  CircleAvatar circleFile() {
    return CircleAvatar(
      backgroundImage: FileImage(file!),
    );
  }

  CircleAvatar circleNetwork() {
    return CircleAvatar(
      backgroundImage: NetworkImage(urlImage!),
    );
  }

  CircleAvatar circleAsset() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: AssetImage(
        'assets/images/bedridden.png',
      ),
    );
  }

  DecorationImage showLogo() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/bedridden.png"),
    );
  }

  Future<Null> processGetImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Future<Null> confirmImageDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          // leading: Image.asset("assets/images/bedridden.png"),
          title: Text('กรุณาเลือกแหล่งภาพ'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processGetImage(ImageSource.camera);
            },
            child: Text('กล้อง'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              processGetImage(ImageSource.gallery);
            },
            child: Text('อัลบั้ม'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('ยกเลิก'),
          ),
        ],
      ),
    );
  }

  buildEditImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 1, left: 170),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () => confirmImageDialog(),
        ),
      ),
    );
  }

  Padding buildUpdateImage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 260, left: 4),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (file == null) {
              normalDialog(context, 'กรุณาใส่ภาพ');
            } else {
              processChangeImageProfile();
            }
          },
        ),
      ),
    );
  }

  Future<Null> processChangeImageProfile() async {
    String nameImage = 'profile${Random().nextInt(100000)}.jpg';
    print('## nameImage ==>> $nameImage');
    await Firebase.initializeApp().then((value) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('profile/$nameImage');
      UploadTask task = reference.putFile(file!);
      await task.whenComplete(() async {
        await reference.getDownloadURL().then((value) async {
          print('Upload Success access Token ==> $value');
          String urlProfile = value.toString();
          FirebaseAuth.instance.authStateChanges().listen((event) async {
            await event!.updatePhotoURL(urlProfile).then((value) =>
                normalDialog(context, 'Update Image Profile Success'));
          });
        });
      });
    });
  }

  Future<Null> processChangeDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) async {
        await event!
            .updateDisplayName(userNameController.text)
            .then((value) => normalDialog(context, 'เสร็จสิ้น'));
      });
    });
  } // end build
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xffdfad98);
    Path path = Path()
      ..relativeLineTo(0, 280)
      ..quadraticBezierTo(
        size.width,
        280,
        size.width,
        280,
      )
      ..relativeLineTo(0, -280)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
