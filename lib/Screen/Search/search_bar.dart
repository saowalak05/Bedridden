import 'package:bedridden/DataController.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    
    Key? key,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<String> sickmodels = [];
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;

  var val;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(snapshotData.docs[index]['urlImage']),
            ),
            title: Text(
              snapshotData.docs[index]['name'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            subtitle: Text(
              snapshotData.docs[index]['level'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          );
        },
      );
    }

    var getBuilder = GetBuilder;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          backgroundColor: Color(0xffdfad98),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
            val.queryData(searchController.text).then((value) {
              snapshotData = value;
              setState(() {
                isExcecuted = true;
              });
            });
          }),
      backgroundColor: Color(0xfff7e4db),
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(icon: Icon(Icons.search), onPressed: () {});
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Search', hintStyle: TextStyle(color: Colors.black)),
          controller: searchController,
        ),
        backgroundColor: Color(0xffdfad98),
      ),
    );
  }
}
