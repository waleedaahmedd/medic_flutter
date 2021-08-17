import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_flutter_app/ApiClients/CartApiClient.dart';
import 'package:medic_flutter_app/Requests/UpdateCartItemRequest.dart';
import 'package:medic_flutter_app/Responses/UpdateCartItemResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/totalAmount.dart';
import 'package:dio/dio.dart';

typedef void IntCallback(int val);

class CartQuantityCounter extends StatefulWidget {
  final int quantity;
  final int itemId;
  final IntCallback callback;
  final double itemPrice;

  const CartQuantityCounter(this.quantity, this.itemId, this.itemPrice,
      {this.callback});

  @override
  _CartQuantityCounterState createState() =>
      _CartQuantityCounterState(quantity, itemId, itemPrice, callback);
}

class _CartQuantityCounterState extends State<CartQuantityCounter> {
  int _quantity;
  int _itemId;
  IntCallback _callback;
  double _itemPrice;
  RestClient _restClient = new RestClient();
  bool pressed = false;
  final UpdateCartItemRequest request = new UpdateCartItemRequest();

  _CartQuantityCounterState(
      int quantity, int itemId, double itemPrice, IntCallback callback) {
    this._quantity = quantity;
    this._callback = callback;
    this._itemPrice = itemPrice;
    this._itemId = itemId;
  }

  @override
  Widget build(BuildContext context) {
    double _itemWithQuantity = _itemPrice * _quantity;
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            if (_quantity <= 1) {
                              Fluttertoast.showToast(
                                  msg: "Quantity Should not be less then 1",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              setState(() {
                                _quantity = --_quantity;
                                _callback(_quantity);
                                request.itemId = _itemId;
                                request.quantity = _quantity;
                                pressed = true;
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 16,
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),
                        child: Text(
                          _quantity.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              _quantity = ++_quantity;
                              request.itemId = _itemId;
                              request.quantity = _quantity;
                              pressed = true;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Rs " + _itemWithQuantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        pressed
            ? _buildBody(context, _restClient.jwtToken, request)
            : Container(),
      ],
    );
  }

  FutureBuilder<UpdateCartItemResponse> _buildBody(
      BuildContext context, RestClient, UpdateCartItemRequest request) {
    final client =
        CartApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<UpdateCartItemResponse>(
      future: client.updateCartItem(RestClient, request),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final UpdateCartItemResponse posts = snapshot.data;
          if (posts.responseCode == '00') {
            Future.delayed(
                Duration.zero,
                () => TotalAmount.newTotalAmount.value =
                    posts.cartTotalPrice.toString());
            return Container();
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
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }
}
