import 'package:medic_flutter_app/Responses/OrderAddressDto.dart';

import 'OrderedItemsDto.dart';
import 'OrdersDto.dart';

class OrderDetailsResponse {
  String responseCode;
  String responseMessage;
  OrdersDto order;
  List<OrderedItemsDto> orderedItems;
  OrderAddressDto orderAddress;

  OrderDetailsResponse(
      {this.responseCode,
      this.responseMessage,
      this.order,
      this.orderedItems,
      this.orderAddress});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    order = json['order'];

    if (json['orderedItems'] != null) {
      orderedItems = new List<OrderedItemsDto>();
      json['orderedItems'].forEach((v) {
        orderedItems.add(new OrderedItemsDto.fromJson(v));
      });
    }

    orderAddress = json['orderAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['order'] = this.order;

    if (this.orderedItems != null) {
      data['orderedItems'] = this.orderedItems.map((v) => v.toJson()).toList();
    }

    data['orderAddress'] = this.orderAddress;

    return data;
  }
}
