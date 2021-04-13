import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'RegisterInputField.dart';
import 'RegisterPage.dart';

class RegisterInputWraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: RegisterInputField(),
          ),
          SizedBox(
            height: 40,
          ),
          ButtonTheme(
            height: 50,
            minWidth: double.infinity, // <-- match_parent
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                // side: BorderSide(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.pop(
                    context,
                   );
              },
              color: Colors.red,
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Already have an Account ",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
