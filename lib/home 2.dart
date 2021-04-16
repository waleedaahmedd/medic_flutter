//import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'SwipeDrwer.dart';
import 'Widgets/myDrawer.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add this line so you can add your appBar in Body
      extendBodyBehindAppBar: true,
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,

        //hasClone: true,
        bodyBackgroundPeekSize: 40,
        bodySize: 100,
        backgroundColor: Colors.red[600],
        // pass drawer widget
        drawer: buildDrawer(),
        // pass body widget
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          height: 160.0,
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Center(
                  child: Text(
                    "Medic",
                    style: TextStyle(color: Colors.red, fontSize: 18.0),
                  ),
                ),
              ),
              Positioned(
                top: 80.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.0),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 1.0),
                        color: Colors.white),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if (drawerKey.currentState.isOpened()) {
                              drawerKey.currentState.closeDrawer();
                            } else {
                              drawerKey.currentState.openDrawer();
                            }
                          },
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            print("your menu action here");
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            print("your menu action here");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // build your appBar
        /*AppBar(
          title: Text('AppBar title'),
          backgroundColor: Colors.amber,
          leading: InkWell(
              onTap: () {
                if (drawerKey.currentState.isOpened()) {
                  drawerKey.currentState.closeDrawer();
                } else {
                  drawerKey.currentState.openDrawer();
                }
              },
              child: Icon(Icons.menu)),
        ),*/
        // build your screen body
        Expanded(
          child: Container(
            color: Colors.black12,
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDrawer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                  fit: BoxFit.fill
              ),
            ),
          ),
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
        ],
      ),
    );
  }
}
