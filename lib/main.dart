import 'package:flutter/material.dart';
import 'Login/LoginPage.dart';
import 'package:flutter/services.dart';

void main() {
  //setup();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'Login_Api/LoginUserRequest.dart';
import 'Login_Api/LoginUserResponse.dart';
import 'Login_Api/login_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  bool pressed = false;
  final LoginUserRequest request = new LoginUserRequest();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrofit Post Call"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            RaisedButton(child: Text("Fetch Post"),
                onPressed: () => {setState(() {
                  request.userName = '923132797806';
                  request.password = 'abc@123';
                  pressed = true;
                  //fetchData(postNum);
                })}),

            Padding(padding: EdgeInsets.all(30)),

            pressed ? _buildBody(context,request) : SizedBox(),

          ],
        ),
      ),
    );
  }
}



FutureBuilder<LoginUserResponse> _buildBody(BuildContext context,LoginUserRequest request) {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<LoginUserResponse>(
    future: client.loginUser(request),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final LoginUserResponse posts = snapshot.data;
        return _buildPosts(context, posts);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget _buildPosts(BuildContext context, LoginUserResponse posts) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Name : " + posts.responseCode,
          style: TextStyle(fontSize: 30),
        ),
        Text(
          "Age : " + posts.userName.toString(),
          style: TextStyle(fontSize: 30),
        ),
      ],
    ),
  );*/
//}


