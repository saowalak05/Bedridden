import 'package:flutter/material.dart';

class calculate extends StatelessWidget {
  const calculate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final IconThemeData data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdfad98),
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(50.0, 50.0))),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildSearchBedridden(context),
          biludListBedridden(),
          MaterialButton(
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
        "คำนวณ",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      color: const Color(0xffdfad98),
    ),
        ],
      ),
    );
  }

  Column biludListBedridden() {
    return Column(
          children: [
             SizedBox(
          height: 20,
        ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'ชื่อ-นามสุกล',
                fillColor: const Color(0xfff7e4db),
                suffixIcon: IconButton(onPressed: (null), icon: Icon(Icons.delete_outlined),)
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'ชื่อ-นามสุกล',
                fillColor: const Color(0xfff7e4db),
                suffixIcon: IconButton(onPressed: (null), icon: Icon(Icons.delete_outlined),)
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'ชื่อ-นามสุกล',
                fillColor: const Color(0xfff7e4db),
                suffixIcon: IconButton(onPressed: (null), icon: Icon(Icons.delete_outlined),)
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        );
  }

  Center buildSearchBedridden(BuildContext context) {
    return Center(
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: TextField(
              // controller: TextEditingController(),
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(
                  hintText: "เพิ่มรายชื่อการคำนวณ ",
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                  suffixIcon: Material(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(Icons.search),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
            ),
            
          ),
        ),
      ],
    ),
  );
  }
}
