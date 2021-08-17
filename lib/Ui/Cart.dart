import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CartApiClient.dart';
import 'package:medic_flutter_app/Responses/CartDeleteResponse.dart';
import 'package:medic_flutter_app/Responses/CartDetailDTO.dart';
import 'package:medic_flutter_app/Responses/CartDetailResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/buttonWithBorder.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:medic_flutter_app/Widgets/cartQuantityCounter.dart';
import 'package:medic_flutter_app/Widgets/badgeWithCart.dart';
import 'package:medic_flutter_app/Widgets/buildCartList.dart';

import 'package:medic_flutter_app/Ui/SubmitForm.dart';
import 'package:dio/dio.dart';
import 'package:medic_flutter_app/Widgets/quantityCounter.dart';
import 'package:medic_flutter_app/Widgets/totalAmount.dart';
import 'package:page_transition/page_transition.dart';

import 'MedicineDetail.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  RestClient _restClient = new RestClient();

  bool deleteButtonPressed = false;
  bool runCartDetails = true;
  int currentCartId;

/*
  final key = GlobalKey<AnimatedListState>();
*/
  // double _totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    int _totalitems = _restClient.itemCount;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
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
              Visibility(
                visible: (_totalitems != 0),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () => showCustomDialog(context, "Delete Cart",
                          "Do you really want to Delete The Whole Cart ?"),
                      label: const Text('Delete Cart'),
                      icon: const Icon(Icons.remove_shopping_cart),
                      // backgroundColor: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TotalAmount(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Items: $_totalitems",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: runCartDetails
                      ? _buildBody(context, _restClient.jwtToken)
                      : Container(),
                ),
                Visibility(
                  visible: (_totalitems != 0),
                  child: Positioned(
                    right: 10,
                    bottom: 10,
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: OrderSubmit(cartId: currentCartId),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 500)));
                      },
                      label: const Text('CheckOut Now'),
                      icon: const Icon(Icons.thumb_up),
                      // backgroundColor: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          deleteButtonPressed
              ? _buildBodyCartDelete(context, RestClient())
              : Container(),
        ],
      ),
    );
  }

  FutureBuilder<CartDetailResponse> _buildBody(
      BuildContext context, RestClient) {
    final client =
        CartApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<CartDetailResponse>(
      future: client.getCart(RestClient),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final CartDetailResponse posts = snapshot.data;
          if (posts.responseCode == '00') {
            currentCartId = posts.cartId;
            List<CartDetailDTO> post = posts.cartItems;
            if (posts.totalPrice.toString() == "null") {
              Future.delayed(
                  Duration.zero, () => TotalAmount.newTotalAmount.value = "0");
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_outlined,
                      size: 140,
                      color: Colors.grey,
                    ),
                    Text(
                      "Cart is Empty",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else {
              Future.delayed(
                  Duration.zero,
                  () => TotalAmount.newTotalAmount.value =
                      posts.totalPrice.toString());
              return Container(
                child: _buildPosts(context, post),
                /**/
              );
            }
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

  ListView _buildPosts(BuildContext context, List<CartDetailDTO> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(4),
      physics: BouncingScrollPhysics(),
      // Only for iOS

      itemBuilder: (context, index) {
        return new BuildCartList(posts, index, notifyParent: refresh);
      },
    );
  }

  FutureBuilder<CartDeleteResponse> _buildBodyCartDelete(
      BuildContext context, RestClient restClient) {
    final client =
        CartApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<CartDeleteResponse>(
      future: client.deleteCart(restClient.jwtToken),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          EasyLoading.dismiss();
          final CartDeleteResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              Future.delayed(
                  Duration.zero, () => badgeWithCart.newCartCount.value = 0);
              Fluttertoast.showToast(
                  msg: "Cart Deleted Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM_LEFT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  fontSize: 16.0);

              setState(() {
                restClient.itemCount = 0;
                runCartDetails = true;
                deleteButtonPressed = false;
              });
            } else {
              EasyLoading.showError(posts.responseMessage);
            }
          });
          return Container();
        } else {
          return Container(width: 0, height: 0);
        }
      },
    );
  }

  refresh() {
    setState(() {});
  }

  showCustomDialog(BuildContext context, String title, String description) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              // textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyText1,
                // textAlign: TextAlign.right,
              ),
            ),
            actions: [
              ButtonWithBorder(
                text: 'Yes',
                onPressed: () => setState(() {
                  Navigator.of(context).pop();
                  deleteButtonPressed = true;
                  runCartDetails = false;
                  EasyLoading.show(status: 'Please Wait...');
                }),
              ),
              ButtonWithoutBorder(
                text: 'No',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
          );
        });
  }
/*void removeItem(int index) {
    final item = removeItem(index);
    key.currentState.removeItem(index, (context, animation) => buildItem());
  }

  void buildItem(CartDetailDTO posts, int index, Animation<double> animation) {
    int _quantity = posts.itemQuantity;
    int _itemId = posts[index].itemId;
  }*/
}
