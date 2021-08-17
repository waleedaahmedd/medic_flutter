import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medic_flutter_app/Requests/RegisterUserRequest.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:page_transition/page_transition.dart';

import '../Otp Screen.dart';
import 'RegisterPage.dart';

class RegisterInputWraper extends StatefulWidget {
  const RegisterInputWraper({Key key}) : super(key: key);

  @override
  _RegisterInputWraperState createState() => _RegisterInputWraperState();
}

class _RegisterInputWraperState extends State<RegisterInputWraper> {
  final RegisterUserRequest request = new RegisterUserRequest();
  final _passwordFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  String _password;
  String _phone;
  String _countryCode;
  String _loaderWaitingText;
  bool pressed = false;

  // RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Expanded(
                        //  flex:6,
                        child: Form(
                          // key: _phoneFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                //   style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                ),
                                validator: _validatePhone,
                                onSaved: (value) => _phone = value,
                              ),
                              /*  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0))*/
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      new Expanded(
                        //  flex:6,
                        child: Form(
                          //  key: _phoneFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.number,
                                //   style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                ),
                                validator: _validatePhone,
                                onSaved: (value) => _phone = value,
                              ),
                              /*  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0))*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: new SizedBox(
                          width: 100,
                          child: CountryCodePicker(
                            initialSelection: 'PK',
                            textStyle: TextStyle(
                                fontSize: 15.0, color: Colors.black87),
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
                                // style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                ),
                                validator: _validatePhone,
                                onSaved: (value) => _phone = value,
                              ),
                              /* Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0))*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    //  key: _phoneFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.number,
                          //  style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                          ),
                          validator: _validatePhone,
                          onSaved: (value) => _phone = value,
                        ),
                        /* Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0))*/
                      ],
                    ),
                  ),
                  Form(
                    key: _passwordFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          //   style: TextStyle(fontSize: 18),
                          // obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: _validatePassword,
                          onSaved: (value) => _password = value,
                        ),
                        /* Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0))*/
                      ],
                    ),
                  ),
                  Form(
                    // key: _passwordFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          //   style: TextStyle(fontSize: 18),
                          // obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          validator: _validatePassword,
                          onSaved: (value) => _password = value,
                        ),
                        /*Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0))*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ButtonWithoutBorder(
                text: 'Register',
                onPressed: () => {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OtpScreen(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 500))),
                  /* setState(
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      if (_phoneFormKey.currentState.validate() &&
                          _passwordFormKey.currentState.validate()) {
                        _phoneFormKey.currentState.save();
                        _passwordFormKey.currentState.save();
                        _loaderWaitingText = 'Please Wait';
                        pressed = true;
                        request.phoneNumber = _countryCode + _phone;
                        request.password = _password;
                        //_timer?.cancel();
                      }
                    },
                  )*/
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Already have an Account ",
              style: TextStyle(color: Colors.black),
            ),
            /*  SizedBox(
              height: 20,
            ),*/
            SizedBox(
              height: 20,
            ),
            // pressed ? _buildBody(context, request) : Container(),
          ],
        ),
      ),
    );
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

/*
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
*/

}
