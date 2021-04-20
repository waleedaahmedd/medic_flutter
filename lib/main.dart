import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'Ui/HomeScreen.dart';
import 'Ui/Login/LoginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  var password = prefs.getString('password');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  autoLogin(username, password);
  //runApp(MaterialApp(home: username == null ? LoginPage() : RegisterPage()));
}

void autoLogin(String username, password) {
 // if (username == null) {
    runApp(LoginApp());
 // }
 // runApp(showHomeScreen());
  // runApi(username, password);
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
        textTheme: TextTheme(bodyText2: TextStyle(color: Theme.of(context).primaryColor)),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class showHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
