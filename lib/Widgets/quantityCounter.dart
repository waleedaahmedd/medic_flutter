import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef void IntCallback(int val);

class QuantityCounter extends StatefulWidget {
  final int quantity;
  final IntCallback callback;

  const QuantityCounter(this.quantity, {this.callback});

  @override
  _QuantityCounterState createState() =>
      _QuantityCounterState(quantity, callback);
}

class _QuantityCounterState extends State<QuantityCounter> {
  int _quantity;
  IntCallback _callback;

  _QuantityCounterState(int quantity, IntCallback callback) {
    this._quantity = quantity;
    this._callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    //int _quantity = quantity;

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).accentColor),
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
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Text(
              _quantity.toString(),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  _quantity = ++_quantity;
                  _callback(_quantity);
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              )),
        ],
      ),
    );
  }
}
