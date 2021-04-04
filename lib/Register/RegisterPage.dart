import 'package:flutter/material.dart';
import 'RegisterHeader.dart';
import 'RegisterInputWraper.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.red[500],
            Colors.red[300],
            Colors.red[400],
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            RegisterHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: RegisterInputWraper(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
