import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: Image.asset('assets/images/exclamation_mark.png'),
        
        subtitle: Text(string),
      
      ),
      children: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')
        ),
      ],
    ),
  );
}
