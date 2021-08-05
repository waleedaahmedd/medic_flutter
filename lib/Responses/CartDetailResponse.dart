import 'dart:ffi';

import 'CartDetailDTO.dart';

class CartDetailResponse {
  String responseCode;
  String responseMessage;
  int cartId;
  double totalPrice;
  List<CartDetailDTO> cartItems;
  String phoneNumber;
  String userName;

  CartDetailResponse(
      {this.responseCode,
      this.responseMessage,
      this.cartId,
      this.totalPrice,
      this.cartItems,
      this.phoneNumber,
      this.userName});

  CartDetailResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    cartId = json['cartId'];
    totalPrice = json['totalPrice'];
    if (json['cartItems'] != null) {
      cartItems = new List<CartDetailDTO>();
      json['cartItems'].forEach((v) {
        cartItems.add(new CartDetailDTO.fromJson(v));
      });
    }
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['cartId'] = this.cartId;
    data['totalPrice'] = this.totalPrice;

    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems.map((v) => v.toJson()).toList();
    }

    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    return data;
  }
}
