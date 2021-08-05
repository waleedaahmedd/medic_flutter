import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/badgeWithCart.dart';

class HeaderWithCart extends StatefulWidget {
  const HeaderWithCart({Key key}) : super(key: key);

  @override
  _HeaderWithCartState createState() => _HeaderWithCartState();
}

class _HeaderWithCartState extends State<HeaderWithCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          badgeWithCart(),

          /*Badge(
              position: BadgePosition.topEnd(top: 5, end: 10),
              badgeContent: Text(
                _restClient.itemCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child:
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}))*/

          /* Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
            ),
          ),*/

          /*Center(
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
          ),*/
        ],
      ),
    );
  }
}

/*
class HeaderWithCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //  RestClient _restClient = new RestClient();

    // SingletonClass jwtToken = SingletonClass();
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    Navigator.pop(
                      context,
                    )setState(() {});
                  },
                ),
              ),
            ),
          ),
          badgeWithCart(),

          */
/*Badge(
              position: BadgePosition.topEnd(top: 5, end: 10),
              badgeContent: Text(
                _restClient.itemCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child:
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}))*/ /*


          */
/* Container(
            child: Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
            ),
          ),*/ /*


          */
/*Center(
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
          ),*/ /*

        ],
      ),
    );
  }
}
*/
