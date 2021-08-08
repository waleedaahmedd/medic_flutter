import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Ui/Cart.dart';
import 'package:page_transition/page_transition.dart';

class badgeWithCart extends StatelessWidget {
  static ValueNotifier<int> newCartCount = ValueNotifier(0);
  static RestClient _restClient = new RestClient();

  const badgeWithCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
        position: BadgePosition.topEnd(top: 5, end: 10),
        badgeContent: ValueListenableBuilder(
            valueListenable: newCartCount,
            builder: (BuildContext context, int newValue, Widget child) {
              _restClient.itemCount = newValue;
              return Text(
                "$newValue",
                //setCartCount(newValue),

                /* _restClient.itemCount.toString(),*/
                style: TextStyle(color: Colors.white, fontSize: 10),
              );
            }),
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Cart(),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500)));
            }));
  }

  /*String setCartCount(int newValue) {
    if (newValue == 0) {
      return _restClient.itemCount.toString();
    } else
      return "$newValue";
  }*/
}

/*// ignore: camel_case_types
class badgeWithCart extends StatefulWidget {
  const badgeWithCart({Key key}) : super(key: key);

  @override
  _badgeWithCartState createState() => _badgeWithCartState();
}

// ignore: camel_case_types
class _badgeWithCartState extends State<badgeWithCart> {

  @override
  Widget build(BuildContext context) {
    // RestClient _restClient = new RestClient();

    return
  }
}*/
