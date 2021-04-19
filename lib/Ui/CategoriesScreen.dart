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
            child: LinearProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List<CategoryDTO> posts) {
    Uint8List bytes ;
    final imageFeatured1 = "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";

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
          //  subtitle: Text(posts[index].categoryIcon),

            leading: Column(
              children: <Widget>[

                new Image.memory(posts[index].getImage())

              ],

            ),
          ),
        );
      },
    );
  }
}

/*class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<>[]

    */ /* List<String> images = [
      "https://placeimg.com/500/500/any",
      "https://placeimg.com/500/500/any",
      "https://placeimg.com/500/500/any",
      "https://placeimg.com/500/500/any",
      "https://placeimg.com/500/500/any"
    ];*/ /*


    return Container(
      padding: EdgeInsets.all(60.0),
      child: GridView.builder(
      */ /*  itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(images[index]);
        },*/ /*
      ),
    );
  }


}*/
