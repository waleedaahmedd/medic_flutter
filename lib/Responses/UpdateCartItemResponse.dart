import 'dart:ffi';

class UpdateCartItemResponse {
  double cartTotalPrice;
  double itemPrice;
  String responseCode;
  String responseMessage;

  UpdateCartItemResponse(
      {this.responseCode,
      this.responseMessage,
      this.itemPrice,
      this.cartTotalPrice});

  UpdateCartItemResponse.fromJson(Map<String, dynamic> json) {
    cartTotalPrice = json['cartTotalPrice'];
    itemPrice = json['itemPrice'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartTotalPrice'] = this.cartTotalPrice;
    data['itemPrice'] = this.itemPrice;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;

    return data;
  }
}
