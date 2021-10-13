import 'package:bedridden/DataController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;

  get val => null;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(snapshotData.docs[index].data()['urlImage']),
            ),
            title: Text(
              snapshotData.docs[index].data()['name'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            subtitle: Text(
              snapshotData.docs[index].data()['level'],
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          getBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(icon: Icon(Icons.search), onPressed: () {});
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Search', hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
        backgroundColor: Colors.black,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text(
                  'Search any courses',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}

