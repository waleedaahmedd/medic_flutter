import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/MedicinesApiClient.dart';
import 'package:medic_flutter_app/Responses/MedicineDTO.dart';
import 'package:medic_flutter_app/Responses/MedicineListResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context, _restClient.jwtToken, 0, 150, "a"),
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

  GridView _buildPosts(BuildContext context, List<MedicineDTO> posts) {
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
                  /*new Center(
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
                  ),*/
                  Flexible(
                    child: Text(
                      posts[index].medicineName,
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
            Fluttertoast.showToast(msg: 'asdsdsd');
          },
        );
      },
    );
  }
}
