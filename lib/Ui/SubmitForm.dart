import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSubmit extends StatefulWidget {
  const OrderSubmit({Key key}) : super(key: key);

  @override
  _OrderSubmitState createState() => _OrderSubmitState();
}

class _OrderSubmitState extends State<OrderSubmit> {
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
              //key: _phoneFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    // style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      labelText: 'Receiver Name',
                      border: OutlineInputBorder(),
                    ),
                    //  validator: _validatePhone,
                    //  onSaved: (value) => _phone = value,
                  ),
                  // Padding(padding: const EdgeInsets.symmetric(vertical: 20.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              //key: _phoneFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    // style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Receiver Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    //  validator: _validatePhone,
                    //  onSaved: (value) => _phone = value,
                  ),
                  // Padding(padding: const EdgeInsets.symmetric(vertical: 20.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              //key: _phoneFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //   style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Nearby Location',
                      border: OutlineInputBorder(),
                    ),
                    //  validator: _validatePhone,
                    //  onSaved: (value) => _phone = value,
                  ),
                  //Padding(padding: const EdgeInsets.symmetric(vertical: 20.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Form(
              //key: _phoneFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //  style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'House Number',
                      border: OutlineInputBorder(),
                    ),
                    //  validator: _validatePhone,
                    //  onSaved: (value) => _phone = value,
                  ),
                  // Padding(padding: const EdgeInsets.symmetric(vertical: 20.0))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
