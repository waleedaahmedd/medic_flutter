import 'dart:ffi';

class CartItemDeleteResponse {
  String responseCode;
  String responseMessage;
  Double totalPrice;

  CartItemDeleteResponse(
      {this.responseCode, this.responseMessage, this.totalPrice});

  CartItemDeleteResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
