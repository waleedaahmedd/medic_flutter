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
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:medic_flutter_app/Widgets/cartQuantityCounter.dart';
import 'package:medic_flutter_app/Ui/MedicineList.dart';
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
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    deleteButtonPressed = true;
                    runCartDetails = false;
                    EasyLoading.show(status: 'Please Wait...');
                  }),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                      ),
                      //    side: BorderSide(color: Colors.red),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),

                    /*  padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50.0)),*/
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        'Delete Cart',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                /*child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                _buildBody(context, _restClient.jwtToken),
                          ),
                          Text(
                            'Delete Cart',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
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
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: runCartDetails
                      ? _buildBody(context, _restClient.jwtToken)
                      : Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 50),
                    child: ButtonWithoutBorder(
                      text: 'Add to Cart',
                      onPressed: () => setState(() {
                        /*request.medicineId = widget.medicine.medicineId;
                    request.quantity = _quantity.toString();
                    pressed = true;*/
                        /* _buildBody(
                                      context, _restClient.jwtToken, request);*/
                      }),
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
                      Icons.shopping_cart,
                      size: 140,
                    ),
                    Text("Cart is Empty"),
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

  /*AnimatedList _buildPosts(BuildContext context, List<CartDetailDTO> posts) {
    return AnimatedList(
      key: key,
      initialItemCount: posts.length,
      padding: EdgeInsets.all(4),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index, animation) {

buildItem(posts[index],index,animation);
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].medicineName.toUpperCase(),
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].medicineQuantity.toString() +
                                  posts[index].medicineUnit +
                                  " By " +
                                  posts[index].manufacturer,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
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
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    "Old Price: " +
                                        posts[index]
                                            .itemPriceWithoutQuantityAndDiscount
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CartQuantityCounter(
                                _quantity, _itemId, _itemPrice,
                                callback: (val) => _quantity = val),
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
            removeItem(posts[index] as int);
          },
        );
      },
    );
  }*/

  ListView _buildPosts(BuildContext context, List<CartDetailDTO> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(4),
      physics: BouncingScrollPhysics(),
      // Only for iOS
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //    crossAxisCount: 1, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (context, index) {
        int _quantity = posts[index].itemQuantity;
        int _itemId = posts[index].itemId;
        double _itemPrice = posts[index].itemPriceWithSingleQuantityAndDiscount;
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].medicineName.toUpperCase(),
                              style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              posts[index].medicineQuantity.toString() +
                                  posts[index].medicineUnit +
                                  " By " +
                                  posts[index].manufacturer,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
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
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Text(
                                    "Old Price: " +
                                        posts[index]
                                            .itemPriceWithoutQuantityAndDiscount
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CartQuantityCounter(
                                _quantity, _itemId, _itemPrice,
                                callback: (val) => _quantity = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {},
        );
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
          final CartDeleteResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              EasyLoading.showSuccess("Cart Deleted Successfully");
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

          /*Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );*/
        }
      },
    );
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
