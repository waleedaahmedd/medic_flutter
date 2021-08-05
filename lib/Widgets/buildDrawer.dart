import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDrawer() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
                    'https://googleflutter.com/sample_image.jpg'),
                fit: BoxFit.fill),
          ),
        ),
        _createDrawerItem(
          icon: Icons.contacts,
          text: 'Contacts',
        ),
        _createDrawerItem(
          icon: Icons.contacts,
          text: 'Contacts',
        ),
        _createDrawerItem(
          icon: Icons.contacts,
          text: 'Contacts',
        ),
        _createDrawerItem(
          icon: Icons.contacts,
          text: 'Contacts',
        ),

      ],
    ),
  );
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}