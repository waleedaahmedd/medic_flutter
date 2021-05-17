import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  configLoading();

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

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.red
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.red
    ..textColor = Colors.red
    ..maskColor = Colors.red.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Theme.of(context).primaryColor)),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      builder: EasyLoading.init(),
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
