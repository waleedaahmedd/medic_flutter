import 'dart:ffi';

class OrdersDto {
  int orderId;
  String status;
  Double totalPrice;
  String createdOn;
  String referenceNumber;
  String userName;
  String phoneNumber;
  int totalItems;
  String receiverName;
  String message;
  String code;

  OrdersDto(
      {this.orderId,
      this.status,
      this.totalPrice,
      this.createdOn,
      this.referenceNumber,
      this.userName,
      this.phoneNumber,
      this.totalItems,
      this.receiverName,
      this.message,
      this.code});

  OrdersDto.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    status = json['status'];
    totalPrice = json['totalPrice'];
    createdOn = json['createdOn'];
    referenceNumber = json['referenceNumber'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    totalItems = json['totalItems'];
    receiverName = json['receiverName'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['status'] = this.status;
    data['totalPrice'] = this.totalPrice;
    data['createdOn'] = this.createdOn;
    data['referenceNumber'] = this.referenceNumber;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['totalItems'] = this.totalItems;
    data['receiverName'] = this.receiverName;
    data['message'] = this.message;
    data['code'] = this.code;

    return data;
  }
}
