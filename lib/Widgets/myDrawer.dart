import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
        ],
      ),
    );
  }
}
