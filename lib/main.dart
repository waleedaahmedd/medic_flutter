import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:medic_flutter_app/Register/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ApiClients/UserApiClient.dart';
import 'Login/LoginPage.dart';
import 'package:flutter/services.dart';

import 'Login_Api/LoginUserRequest.dart';
import 'Login_Api/LoginUserResponse.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:medic_flutter_app/ApiClients/UserApiClient.dart';
import 'package:medic_flutter_app/Login/LoginPage.dart';
import 'package:medic_flutter_app/Login_Api/LoginUserRequest.dart';
import 'package:medic_flutter_app/Login_Api/LoginUserResponse.dart';
import 'package:medic_flutter_app/Register/RegisterPage.dart';
import 'package:medic_flutter_app/RestClient.dart';

import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  var password = prefs.getString('password');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  autoLogin(username,password);
  //runApp(MaterialApp(home: username == null ? LoginPage() : RegisterPage()));

}

void autoLogin(String username,password) {
if (username == null) {
  runApp(LoginApp());
}
  runApi();
}

void runApi() {

  FutureBuilder<LoginUserResponse> _buildBody(
      BuildContext context, LoginUserRequest request) {
    final client =
    UserApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<LoginUserResponse>(
      future: client.loginUser(request),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final LoginUserResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('username' , emailController.text);
              pref.setString('password', passwordController.text);
              /*   SingletonClass jwtToken = new SingletonClass();
              jwtToken.setJwtToken(posts.jwtToken);*/
              _restClient.jwtToken = posts.jwtToken;
              Navigator.push(
                  context,
                  PageTransition(
                      child: RegisterPage(),
                      type: PageTransitionType.bottomToTop,
                      duration: Duration(milliseconds: 500)));
              Fluttertoast.showToast(
                  msg: posts.responseMessage,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: posts.responseMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });
          return Container();
          // return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}

class LoginApp extends StatelessWidget {
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
