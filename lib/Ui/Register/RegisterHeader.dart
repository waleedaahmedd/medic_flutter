import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../Singleton/RestClient.dart';

class RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  RestClient _restClient = new RestClient();

    // SingletonClass jwtToken = SingletonClass();
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
          Center(
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Welcome to Medic',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
