import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CategoriesApiClient.dart';
import 'package:medic_flutter_app/Responses/CategoryDTO.dart';
import 'package:medic_flutter_app/Responses/CategoryListResponse.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import '../RestClient.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  RestClient _restClient = new RestClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(context, _restClient.jwtToken),
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
            /* SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('username', emailController.text);
              pref.setString('password', passwordController.text);*/
            // SingletonClass jwtToken = new SingletonClass();
            //  jwtToken.setJwtToken(posts.jwtToken);
            /*_restClient.jwtToken = posts.jwtToken;*/
            /*  Navigator.push(
                  context,
                  PageTransition(
                      child: RegisterPage(),
                      type: PageTransitionType.bottomToTop,
                      duration: Duration(milliseconds: 500)));*/
            Fluttertoast.showToast(
                msg: posts.responseMessage,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: posts.responseMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          //  return Container();
          // return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white,),
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
            child:Padding(
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
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Colors.black),
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

/*  ListView _buildPosts(BuildContext context, List<CategoryDTO> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].categoryName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Column(
              children: <Widget>[new Image.memory(posts[index].getImage())],
            ),
          ),
        );
      },
    );
  }*/
}


