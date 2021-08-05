import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Ui/Cart.dart';
import 'package:page_transition/page_transition.dart';

class badgeWithCart extends StatefulWidget {
  const badgeWithCart({Key key}) : super(key: key);

  @override
  _badgeWithCartState createState() => _badgeWithCartState();
}

class _badgeWithCartState extends State<badgeWithCart> {
  @override
  Widget build(BuildContext context) {
    RestClient _restClient = new RestClient();

    return Badge(
        position: BadgePosition.topEnd(top: 5, end: 10),
        badgeContent: Text(
          _restClient.itemCount.toString(),
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                      context,
                      PageTransition(
                          child: Cart(),
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 500)))
                  .then((_) => setState(() {}));
            }));
  }
}
