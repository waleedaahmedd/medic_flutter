import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CategoriesApiClient.dart';
import 'package:medic_flutter_app/Responses/CategoryDTO.dart';
import 'package:medic_flutter_app/Responses/CategoryListResponse.dart';

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
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {

              List<CategoryDTO> post = posts.categories;
              _buildPosts(context, post);
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
          });
          return Container();
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
            subtitle: Text(posts[index].categoryIcon),
            /*leading: Column(
              children: <Widget>[
                Image.network(posts[index].picture,width: 50,height: 50,
                ),
              ],

            ),*/
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
