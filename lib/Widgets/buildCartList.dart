import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dio/dio.dart';
import 'package:medic_flutter_app/Widgets/badgeWithCart.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CartApiClient.dart';
import 'package:medic_flutter_app/Responses/CartDetailDTO.dart';
import 'package:medic_flutter_app/Responses/CartItemDeleteResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/totalAmount.dart';

import 'buttonWithBorder.dart';
import 'buttonWithoutBorder.dart';
import 'cartQuantityCounter.dart';

class BuildCartList extends StatefulWidget {
  final List<CartDetailDTO> _post;
  final int index;
  final Function() notifyParent;

  const BuildCartList(this._post, this.index, {this.notifyParent});

  @override
  _BuildCartListState createState() => _BuildCartListState();
}

class _BuildCartListState extends State<BuildCartList> {
  bool deleteCartItemPressed = false;
  RestClient _restClient = new RestClient();
  int _itemIdSelected = 0;

  @override
  Widget build(BuildContext context) {
    int _quantity = widget._post[widget.index].itemQuantity;
    int _itemId = widget._post[widget.index].itemId;
    double _itemPrice =
        widget._post[widget.index].itemPriceWithSingleQuantityAndDiscount;
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
                /*child: new Image.memory(
                      (posts[index].getImage()),
                      width: 80.0,
                      height: 80.0,
                      // color: Theme.of(context).primaryColor,
                    ),*/
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete_forever, color: Colors.red),
                          onPressed: () => showCustomDialog(
                              context,
                              "Delete Item",
                              "Do you really want to Delete" +
                                  widget._post[widget.index].medicineName
                                      .toUpperCase() +
                                  "?"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget._post[widget.index].medicineName.toUpperCase(),
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget._post[widget.index].medicineQuantity
                                  .toString() +
                              widget._post[widget.index].medicineUnit +
                              " By " +
                              widget._post[widget.index].manufacturer,
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
                              (widget._post[widget.index].discount.toString() !=
                                  "0"),
                          child: Row(
                            children: <Widget>[
                              Text(
                                widget._post[widget.index].discount.toString() +
                                    "% Off ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "Old Price: " +
                                    widget._post[widget.index]
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
              deleteCartItemPressed
                  ? _buildBodyItemDelete(
                      context, _restClient, _itemId, widget.index)
                  : Container(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }

  FutureBuilder<CartItemDeleteResponse> _buildBodyItemDelete(
      BuildContext context, RestClient restClient, int itemId, int index) {
    final client =
        CartApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<CartItemDeleteResponse>(
      future: client.deleteCartItem(restClient.jwtToken, itemId),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final CartItemDeleteResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              Fluttertoast.showToast(
                  msg: "Item deleted Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  fontSize: 16.0);
              setState(() {
                deleteCartItemPressed = false;
                int itemCount = --restClient.itemCount;
                // restClient.itemCount = itemCount;
                widget.notifyParent();
                Future.delayed(Duration.zero, () {
                  /* TotalAmount.newTotalAmount.value =
                      posts.totalPrice.toString();*/
                  badgeWithCart.newCartCount.value = itemCount;
                });
              });

              //EasyLoading.showSuccess("Cart Deleted Successfully");

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
          });
          return Container();
        } else {
          return Container(
            height: 0,
            width: 0,
          );
          /*Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );*/
        }
      },
    );
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
                  deleteCartItemPressed = true;
                  Navigator.of(context).pop();
                  /*  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  );*/
                  Fluttertoast.showToast(
                      msg: "Please Wait while item is deleting from your Cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                      fontSize: 16.0);
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

/*  Future<bool> _onBackPressed() {
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
            onPressed: () => {
              setState(() {
                deleteCartItemPressed = true;
              }),
            },
          ),
        ],
      ),
    );
  }*/
}
