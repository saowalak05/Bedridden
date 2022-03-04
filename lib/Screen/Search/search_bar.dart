import 'package:bedridden/Data/book_data.dart';
import 'package:bedridden/models/book.dart';
import 'package:bedridden/models/sick_model.dart';
import 'package:bedridden/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late List<Book> books;
  String query = '';

  List<SickModel> sickmodels = [];

  @override
  void initState() {
    super.initState();
    sickmodels = sickmodels;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            'Search',
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
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: <Widget>[
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: sickmodels.length,
                  itemBuilder: (context, index) {
                    final sick = sickmodels[index];
                    return buildBook(sick);
                  },
                ),
              ),
            ],
          ),
        )),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchBook,
      );

  Widget buildBook(SickModel sick) => ListTile(
        leading: Image.network(
          sick.urlImage,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
          errorBuilder: (context, exception, stackTrack) => Icon(Icons.error),
        ),
        title: Text(sick.name),
        subtitle: Text(sick.level),
      );

  void searchBook(String query) {
    final sickmodel = sickmodels.where((model) {
      final titleLower = model.name.toLowerCase();
      final authorLower = model.level.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.sickmodels = sickmodels;
    });
  }
}
