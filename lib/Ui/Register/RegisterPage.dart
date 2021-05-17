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
            image: DecorationImage(
                image: AssetImage("assets/splash.png"), fit: BoxFit.cover)),
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
