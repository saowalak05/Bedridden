import 'package:bedridden/Screen/Home/home.dart';
import 'package:bedridden/Screen/Search/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'Search/search_bar.dart';
import 'Profile/profile.dart';
import 'Map/map.dart';
import 'Home/home.dart';

// Adapted from offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/bottom_app_bar_demo.dart
class MyService extends StatefulWidget {
  const MyService({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  int selectedpage = 0;

  final _pageOption = [Home(), SearchBar(), Mappage(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // SliverAppBar is declared in Scaffold.body, in slivers of a
        // CustomScrollView.
        body: _pageOption[selectedpage],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home),
            TabItem(icon: Icons.search),
            // TabItem(icon: Icons.add_location, title: 'Add'),
            TabItem(icon: Icons.map),
            TabItem(icon: Icons.account_circle),
          ],
          initialActiveIndex: selectedpage, //optional, default as 0
          onTap: (int index) {
            setState(() {
              selectedpage = index;
            });
          },
          backgroundColor: const Color(0xffdfad98),
        ));
  }
}
