//import 'package:drawer_swipe/drawer_swipe.dart';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CategoriesApiClient.dart';
import 'package:medic_flutter_app/Responses/CategoryDTO.dart';
import 'package:medic_flutter_app/Responses/CategoryListResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/buildDrawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dio/dio.dart';
import '../Widgets/SwipeDrwer.dart';
import 'package:medic_flutter_app/Widgets/badgeWithCart.dart';
import 'MedicineList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        // add this line so you can add your appBar in Body
        extendBodyBehindAppBar: true,
        body: SwipeDrawer(
          radius: 20,
          key: drawerKey,

          //hasClone: true,
          bodyBackgroundPeekSize: 40,
          bodySize: 200,
          backgroundColor: Colors.red[600],
          // pass drawer widget
          drawer: buildDrawer(this.context),
          // pass body widget
          child: buildBody(),
        ),
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
                color: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Center(
                  child: Text(
                    "Medic",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
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
                            color: Theme.of(context).primaryColor,
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
                        badgeWithCart(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: _buildBody(context, _restClient.jwtToken),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do you really want to exit Medic ?"),
        actions: <Widget>[
          TextButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }

  FutureBuilder<CategoryListResponse> _buildBody(
      BuildContext context, RestClient) {
    final client =
        CategoriesApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<CategoryListResponse>(
      future: client.getCategoryList(RestClient),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final CategoryListResponse posts = snapshot.data;
          if (posts.responseCode == '00') {
            List<CategoryDTO> post = posts.categories;
            return _buildPosts(context, post);
          } else {
            Fluttertoast.showToast(
                msg: posts.responseMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }

  GridView _buildPosts(BuildContext context, List<CategoryDTO> posts) {
    return GridView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(4),
      physics: BouncingScrollPhysics(),
      // Only for iOS
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: Container(
                      child: new Stack(
                        children: <Widget>[
                          new Image.memory(
                            (posts[index].getImage()),
                            width: 60.0,
                            height: 60.0,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      posts[index].categoryName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: MedicineList(categoryId: posts[index].id),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(
                        milliseconds:
                            500)) /*)
                .then((_) => setState(() {})*/
                );
          },
        );
      },
    );
  }
}
