import 'dart:ffi';

class UpdateCartItemRequest {
  int itemId;
  int quantity;

  UpdateCartItemRequest({
    this.itemId,
    this.quantity,
  });

  UpdateCartItemRequest.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['quantity'] = this.quantity;

    return data;
  }
}
