import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/MedicinesApiClient.dart';
import 'package:medic_flutter_app/Responses/MedicineDTO.dart';
import 'package:medic_flutter_app/Responses/MedicineListResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Ui/Header.dart';
import 'package:page_transition/page_transition.dart';
import 'package:medic_flutter_app/Ui/MedicineDetail.dart';

import 'package:retrofit/http.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key key, this.categoryId});

  final int categoryId;

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          HeaderWithCart(),
          Expanded(
            child: Container(
              child: _buildBody(
                  context, _restClient.jwtToken, 0, widget.categoryId, ""),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<MedicineListResponse> _buildBody(
      BuildContext context, RestClient, pageNumber, categoryId, medicineName) {
    final client =
        MedicinesApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<MedicineListResponse>(
      future: client.getMedicineList(
          RestClient, pageNumber, categoryId, medicineName),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final MedicineListResponse posts = snapshot.data;
          if (posts.responseCode == '00') {
            List<MedicineDTO> post = posts.medicines;
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

  //AnimatedList _buildPosts(BuildContext context, List<MedicineDTO> posts)

  ListView _buildPosts(BuildContext context, List<MedicineDTO> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(4),
      physics: BouncingScrollPhysics(),
      // Only for iOS
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //    crossAxisCount: 1, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Image.memory(
                      (posts[index].getImage()),
                      width: 80.0,
                      height: 80.0,
                      // color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          /*Flexible(
                            child: */
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].medicineName.toUpperCase(),
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].quantity.toString() +
                                  posts[index].unit +
                                  " By " +
                                  posts[index].manufacturer,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible:
                                  (posts[index].discount.toString() != "0"),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    posts[index].discount.toString() + "% Off ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    "Old Price: " +
                                        posts[index].price.toString(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration.lineThrough,
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rs " + posts[index].price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    child: MedicineDetail(medicine: posts[index]),
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
