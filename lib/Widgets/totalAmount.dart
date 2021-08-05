import 'package:flutter/material.dart';

class TotalAmount extends StatelessWidget {
  static ValueNotifier<String> newTotalAmount = ValueNotifier('0');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: newTotalAmount,
            builder: (BuildContext context, String newValue, Widget child) {
              return Text(
                "Total Amount: $newValue",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              );
            },
          ),
        ),
      ),
    );
  }
}
