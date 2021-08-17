import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medic_flutter_app/Requests/OrderRequest.dart';

import 'package:medic_flutter_app/Responses/OrderAddressDto.dart';
import 'package:medic_flutter_app/Responses/OrderResponse.dart';
import 'package:medic_flutter_app/Singleton/RestClient.dart';
import 'package:medic_flutter_app/Ui/HomeScreen.dart';
import 'package:medic_flutter_app/Widgets/buttonWithoutBorder.dart';
import 'package:medic_flutter_app/MapPlaces/place_service.dart';
import 'package:medic_flutter_app/MapPlaces/address_search.dart';
import 'package:medic_flutter_app/ApiClients/OrdersApiClient.dart';

import 'package:uuid/uuid.dart';

class OrderSubmit extends StatefulWidget {
  const OrderSubmit({Key key, this.cartId}) : super(key: key);

  final int cartId;

  @override
  _OrderSubmitState createState() => _OrderSubmitState();
}

class _OrderSubmitState extends State<OrderSubmit> {
  RestClient _restClient = new RestClient();
  OrderAddressDto address = new OrderAddressDto();
  OrderRequest request = new OrderRequest();
  final _controllerNearby = TextEditingController();

  final _receiverNameKey = GlobalKey<FormState>();
  final _phoneNumberKey = GlobalKey<FormState>();
  final _houseNumberKey = GlobalKey<FormState>();
  final _nearByLocationKey = GlobalKey<FormState>();

  String _receiverName = '';
  String _phoneNumber = '';
  String _houseNumber = '';
  String _nearByLocation;

  String _city = '';

  String _country = '';
  double _latitude;
  double _longitude;
  bool pressed = false;

  @override
  void dispose() {
    _controllerNearby.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
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
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Deliver To",
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Where Should We Deliver Items?",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 40.0, right: 25.0),
            child: Form(
              key: _receiverNameKey,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Receiver Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
                onSaved: (value) => _receiverName = value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              key: _phoneNumberKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Receiver Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
                onSaved: (value) => _phoneNumber = value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              key: _nearByLocationKey,
              child: TextFormField(
                controller: _controllerNearby,
                readOnly: true,
                onTap: () async {
                  // generate a new token here
                  final sessionToken = Uuid().v4();
                  final Suggestion result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);

                    setState(() {
                      _controllerNearby.text = result.description;
                      _city = placeDetails.city;
                      _country = placeDetails.country;
                      _latitude = double.parse(placeDetails.latitude);
                      _longitude = double.parse(placeDetails.longitude);
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nearby Location',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
                onSaved: (value) => _nearByLocation = value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              key: _houseNumberKey,
              child: TextFormField(
                //  style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'House Number',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
                onSaved: (value) => _houseNumber = value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 40, right: 25.0),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: ButtonWithoutBorder(
                  text: 'Register',
                  onPressed: () {
                    setState(
                      () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (_receiverNameKey.currentState.validate() &&
                            _phoneNumberKey.currentState.validate() &&
                            _nearByLocationKey.currentState.validate() &&
                            _houseNumberKey.currentState.validate()) {
                          _receiverNameKey.currentState.save();
                          _phoneNumberKey.currentState.save();
                          _houseNumberKey.currentState.save();
                          _nearByLocationKey.currentState.save();
                          pressed = true;
                          address.longitude = _longitude;
                          address.lattitude = _latitude;
                          address.country = _country;
                          address.phoneNumber = _phoneNumber;
                          address.nearByLocation = _nearByLocation;
                          address.receiverName = _receiverName;
                          address.city = _city;
                          address.houseNumber = _houseNumber;
                          request.cartId = widget.cartId;
                        }
                      },
                    );
                  }),
            ),
          ),
          pressed
              ? _buildBody(context, request, _restClient.jwtToken)
              : Container(),
        ],
      ),
    );
  }

  FutureBuilder<OrderResponse> _buildBody(
    BuildContext context,
    // int cartId,
    OrderRequest request,
    String jwtToken,
  ) {
    final client =
        OrdersApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<OrderResponse>(
      future: client.placeOrder(jwtToken, request),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final OrderResponse posts = snapshot.data;
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            if (posts.responseCode == '00') {
              EasyLoading.showSuccess(
                  "Your Request Submitted Successfully buy more Medicines");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  ModalRoute.withName("/Home"));
            } else {
              setState(() {
                pressed = false;
              });
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

  // validate phone
  String _validatePhone(String phone) {
    if (phone.length < 8) {
      return 'Phone Number is not valid';
    }
    return null;
  }
}
