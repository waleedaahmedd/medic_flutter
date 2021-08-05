import 'dart:ffi';

import 'OrdersDto.dart';

class GetOrderByUserResponse {
  List<OrdersDto> orders;
  String responseCode;
  String responseMessage;

  GetOrderByUserResponse({
    this.responseCode,
    this.responseMessage,
    this.orders,
  });

  GetOrderByUserResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];

    if (json['cartItems'] != null) {
      orders = new List<OrdersDto>();
      json['cartItems'].forEach((v) {
        orders.add(new OrdersDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;

    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
