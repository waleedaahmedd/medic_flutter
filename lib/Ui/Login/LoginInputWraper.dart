import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:medic_flutter_app/Widgets/badgeWithCart.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/UserApiClient.dart';

import 'package:medic_flutter_app/Requests/LoginUserRequest.dart';
import 'package:medic_flutter_app/Ui/Register/RegisterPage.dart';

import 'package:medic_flutter_app/Responses/LoginUserResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/buttonWithBorder.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:medic_flutter_app/Widgets/progressDialog.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen.dart';

class LoginInputWraper extends StatefulWidget {
  @override
  _LoginInputWraperState createState() => _LoginInputWraperState();
}

class _LoginInputWraperState extends State<LoginInputWraper> {
  Timer _timer;
  // ProgressDialog progressDialog;
  //final TextEditingController phoneController = new TextEditingController();
  bool pressed = false;
  bool _obscureText = true;
  final LoginUserRequest request = new LoginUserRequest();
  final _passwordFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  String _password;
  String _phone;
  String _countryCode;
  String _loaderWaitingText;

  RestClient _restClient = new RestClient();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAlreadyLogin();
  }

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
                  Row(
                    children: <Widget>[
                      new SizedBox(
                        width: 100,
                        child: CountryCodePicker(
                          initialSelection: 'PK',
                          textStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black87),
                          showCountryOnly: false,
                          showDropDownButton: false,
                          showOnlyCountryWhenClosed: false,
                          favorite: ['+92', 'PK'],
                          alignLeft: false,
                          showFlag: true,
                          flagWidth: 30.0,
                          onInit: (CountryCode code) {
                            _countryCode = (code.dialCode);
                            _countryCode = (_countryCode.substring(1));
                          },
                          onChanged: (CountryCode code) {
                            _countryCode = (code.dialCode);
                            _countryCode = (_countryCode.substring(1));
                          },
                        ),
                      ),
                      new Expanded(
                        //  flex:6,
                        child: Form(
                          key: _phoneFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                //style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: 'Enter your Phone',
                                ),
                                validator: _validatePhone,
                                onSaved: (value) => _phone = value,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _passwordFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          //  style: TextStyle(fontSize: 18),
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Enter your Password',
                            suffixIcon: InkWell(
                              onTap: _toggle,
                              child: Icon(
                                _obscureText
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.remove_red_eye,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                            ),
                          ),
                          validator: _validatePassword,
                          onSaved: (value) => _password = value,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ButtonWithoutBorder(
                text: 'Login',
                onPressed: () => {
                  setState(
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      if (_phoneFormKey.currentState.validate() &&
                          _passwordFormKey.currentState.validate()) {
                        _phoneFormKey.currentState.save();
                        _passwordFormKey.currentState.save();
                        _loaderWaitingText = 'Please Wait';
                        pressed = true;
                        request.userName = _countryCode + _phone;
                        request.password = _password;
                        _timer?.cancel();
                      }
                    },
                  )
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ButtonWithBorder(
                  text: 'Register',
                  onPressed: () {
                    _timer?.cancel();
                    EasyLoading.show(status: 'Please Wait...');
                    Navigator.push(
                        this.context,
                        PageTransition(
                            child: RegisterPage(),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 500)));
                    EasyLoading.dismiss();
                  }),
            ),
            pressed ? _buildBody(context, request) : Container(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<LoginUserResponse> _buildBody(
    BuildContext context,
    LoginUserRequest request,
  ) {
    final client =
        UserApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<LoginUserResponse>(
      future: client.loginUser(request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final LoginUserResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              EasyLoading.dismiss();
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('username', request.userName);
              pref.setString('password', request.password);
              _restClient.jwtToken = posts.jwtToken;
              Future.delayed(Duration.zero, () {
                badgeWithCart.newCartCount.value = posts.cartItems;
              });
              //  _restClient.itemCount = posts.cartItems;
              Navigator.push(
                  context,
                  PageTransition(
                      child: HomeScreen(),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500)));
            } else {
              setState(() {
                pressed = false;
              });
              EasyLoading.showError(posts.responseMessage);
            }
          });
          return Container();
        } else {
          EasyLoading.show(status: _loaderWaitingText);
          return Container();
        }
      },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // validate password
  String _validatePassword(String password) {
    if (password.length < 6) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // validate phone
  String _validatePhone(String phone) {
    if (phone.length < 8) {
      return 'Phone Number is not valid';
    }
    return null;
  }

  Future<void> checkAlreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getUserName = prefs.getString('username');
    String getPassword = prefs.getString('password');
    if (getUserName != null) {
      setState(() {
        request.userName = getUserName;
        request.password = getPassword;
        _loaderWaitingText = 'You Are Already Login Please Wait';
        pressed = true;
      });
    }
  }
}
