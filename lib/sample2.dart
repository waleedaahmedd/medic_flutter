import 'package:flutter/material.dart';
import 'package:medic_flutter_app/Login/LoginPage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class sample2 extends StatelessWidget {

  bool _isInAsyncCall = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Modal Progress HUD Demo'),
        backgroundColor: Colors.blue,
      ),*/
      // display modal progress HUD (heads-up display, or indicator)
      // when in async call
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
           child: LoginPage(),
           // child: buildLoginForm(context),
          ),
        ),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
