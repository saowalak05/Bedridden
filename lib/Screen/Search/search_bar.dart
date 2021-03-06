import 'package:bedridden/Screen/Home/listledit.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';
  final primary = Color(0xffdfad98);
  final secondary = Color(0xfff29a94);
  get padding => null;
  List<SickModel> sickmodels = [];
  List<SickModel> sickmodelsread = [];

  @override
  void initState() {
    super.initState();
    readAllSick();
  }

  Future<Null> readAllSick() async {
    Future.delayed(Duration(seconds: 1));
    if (sickmodels.length != 0) {
      sickmodels.clear();
    }
    await Firebase.initializeApp().then((value) async {
      FirebaseFirestore.instance.collection('sick').snapshots().listen((event) {
        for (var item in event.docs) {
          SickModel model = SickModel.fromMap(item.data());
          print('## name ==> ${model.name}');
          setState(() {
            sickmodels.add(model);
            sickmodelsread.add(model);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ค้นหา',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30.0, 30.0))),
      ),
      body: RefreshIndicator(
        onRefresh: readAllSick,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [search(), buildBook()],
              ),
            ),
          ),
        ),
      ),
    );
  }

//'ค้นหารายชื่อ'
  Widget search() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextField(
              onChanged: searchName,
              decoration: InputDecoration(
                  labelText: "ค้นหา",
                  hintText: "ค้นหา",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBook() {
    return Container(
      height: 1000,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 200 / 300,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: sickmodels.length,
        itemBuilder: (context, index) => Container(
          width: 175,
          child: GestureDetector(
            onTap: () {
              var idcard = sickmodels[index].idCard;
              print('## idcard = $idcard');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LitlEdit(idcard: idcard)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(28)),
              child: Card(
                color: Color(0xffFFD1BB),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 150,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            sickmodels[index].urlImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, exception, stackTrack) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                sickmodels[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(sickmodels[index].address),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child:
                                  Text('ระดับที่ ${sickmodels[index].level}'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void searchName(String query) {
    final sickmodelsAll = sickmodelsread.where((sickmodels) {
      final titleLower = sickmodels.name.toLowerCase();
      final authorLower = sickmodels.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.sickmodels = sickmodelsAll;
    });
  }
}
