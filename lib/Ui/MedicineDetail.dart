import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medic_flutter_app/Responses/MedicineDTO.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';

import 'Header.dart';

class MedicineDetail extends StatefulWidget {
  const MedicineDetail({Key key, this.medicine});

  final MedicineDTO medicine;

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  // bool _visibilty = true;

  /* @override
  void initState() {

    // TODO: implement initState
    super.initState();
    if(widget.medicine.description == ""){
      _visibilty = false;
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            HeaderWithCart(),
            Expanded(
              child: Container(
/*
                child: Expanded(
*/
                child: Card(
                  elevation: 10,
                  //shadowColor: Colors.red,
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Image.memory(
                            (widget.medicine.getImage()),
                            width: 200.0,
                            height: 200.0,
                            // color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs." + widget.medicine.calculatedPrice.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.medicine.medicineName.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.medicine.quantity.toString() +
                                widget.medicine.unit +
                                " By " +
                                widget.medicine.manufacturer,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(height: 1, color: Colors.grey),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Discount: " +
                                      widget.medicine.discount.toString() +
                                      "%",
                                  style: TextStyle(
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Old Price: " +
                                      widget.medicine.price.toString(),
                                  style: TextStyle(
                                    color: Colors.orange,
                                    decoration: TextDecoration.lineThrough,
                                    //  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(height: 1, color: Colors.grey),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Quantity ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  widget.medicine.description,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    //  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(height: 1, color: Colors.grey),
                        ),
                        /* Row(
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.medicine.description,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.medicine.description,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(height: 1, color: Colors.grey),
                          ),*/

                        Visibility(
                          visible: (widget.medicine.description != ""),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Description: ',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.medicine.description,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    //  fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(height: 1, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonWithoutBorder(
                              text: 'Add to Cart',
                              onPressed: () => {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
/*
            ),
*/
          ],
        ),
      ),
    );
  }
}
