import 'package:flutter/material.dart';

import 'LoginHeader.dart';
import 'LoginInputWraper.dart';

class LoginPage extends StatelessWidget {
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
              height: 80,
            ),
            LoginHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: LoginInputWraper(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
