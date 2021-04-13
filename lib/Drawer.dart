import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("Header"),
            ),
            ListTile(
              title: Text("Home"),
            )
          ],
        ),
      ),
    );
  }
}
