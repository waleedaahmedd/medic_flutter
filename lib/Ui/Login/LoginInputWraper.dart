import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/UserApiClient.dart';

import 'package:medic_flutter_app/Register/RegisterPage.dart';
import 'package:medic_flutter_app/Requests/LoginUserRequest.dart';
import 'package:medic_flutter_app/Responses/LoginUserResponse.dart';
import 'package:medic_flutter_app/RestClient.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInputWraper extends StatefulWidget {
  @override
  _LoginInputWraperState createState() => _LoginInputWraperState();
}

class _LoginInputWraperState extends State<LoginInputWraper> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool pressed = false;
  final LoginUserRequest request = new LoginUserRequest();

  RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Enter your Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Forgot Password",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),

            //  Button(),

            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //    side: BorderSide(color: Colors.red),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50.0)),
                ),
                onPressed: () => {
                  setState(() {
                    pressed = true;
                    request.userName = emailController.text;
                    request.password = passwordController.text;
                    //fetchData(postNum);
                  })
                },
                //color: Colors.red,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                // textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.red),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50.0)),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: RegisterPage(),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 500)));
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            /*RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            onPressed: () {},
            color: Colors.red,
            textColor: Colors.white,
            child:
                Text("Buy now".toUpperCase(), style: TextStyle(fontSize: 14)),
          ),*/
            pressed ? _buildBody(context, request) : SizedBox(),
          ],
        ),
      ),
    );
  }

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
              pref.setString('username', emailController.text);
              pref.setString('password', passwordController.text);
              // SingletonClass jwtToken = new SingletonClass();
              //  jwtToken.setJwtToken(posts.jwtToken);
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
            child: LinearProgressIndicator(),
          );
        }
      },
    );
  }

/*Widget _buildPosts(BuildContext context, LoginUserResponse posts) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "responseMessage : " + posts.responseMessage,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "jwtToken : " + posts.jwtToken.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
  */ /* if (posts.responseCode == '00') {
      Fluttertoast.showToast(
          msg: posts.responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

        Navigator.push(
            context,
            PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 500)));

    } else {
      Fluttertoast.showToast(
          msg: posts.responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }*/ /*
}*/
}
