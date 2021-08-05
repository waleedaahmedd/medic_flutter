import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medic_flutter_app/ApiClients/CartApiClient.dart';
import 'package:medic_flutter_app/Requests/AddToCartRequest.dart';
import 'package:medic_flutter_app/Responses/AddToCartResponse.dart';
import 'package:medic_flutter_app/Responses/MedicineDTO.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:medic_flutter_app/Widgets/quantityCounter.dart';

import 'Header.dart';

class MedicineDetail extends StatefulWidget {
  const MedicineDetail({Key key, this.medicine});

  final MedicineDTO medicine;

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  int _quantity = 1;
  RestClient _restClient = new RestClient();
  final AddToCartRequest request = new AddToCartRequest();
  bool pressed = false;

  // set string(String value) => setState(() => _string = value);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          HeaderWithCart(),
          Expanded(
            child: Container(
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
                                "Quantity:",
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
                                child: QuantityCounter(_quantity,
                                    callback: (val) => _quantity = val)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(height: 1, color: Colors.grey),
                      ),
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
                            onPressed: () => setState(() {
                              request.medicineId = widget.medicine.medicineId;
                              request.quantity = _quantity.toString();
                              pressed = true;
                              /* _buildBody(
                                    context, _restClient.jwtToken, request);*/
                            }),
                          ),
                        ),
                      ),
                      pressed
                          ? _buildBody(context, _restClient, request)
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<AddToCartResponse> _buildBody(
      BuildContext context, RestClient restClient, AddToCartRequest request) {
    final client =
        CartApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<AddToCartResponse>(
      future: client.addToCart(restClient.jwtToken, request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final AddToCartResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              //int itemCount = restClient.itemCount;
              restClient.itemCount = ++restClient.itemCount;
              EasyLoading.showSuccess("Item Added Successfully");
              setState(() {
                pressed = false;
              });
            } else {
              EasyLoading.showError(posts.responseMessage);
            }
          });
          return Container();
        } else {
          EasyLoading.show(status: 'Please Wait...');
          return Container();
        }
      },
    );
  }
}
