import 'package:medic_flutter_app/Responses/OrderAddressDto.dart';

class OrderRequest {
  int cartId;
  OrderAddressDto address;

  OrderRequest({this.cartId, this.address});

  OrderRequest.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['address'] = this.address;
    return data;
  }
}
