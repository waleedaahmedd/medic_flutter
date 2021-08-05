import 'dart:ffi';

class OrderedItemsDto {
  int itemId;
  String medicineName;
  Double medicinePrice;
  String discount;
  int noOfOrders;
  int noOfItemsAvailable;
  Double totalPrice;

  OrderedItemsDto({
    this.itemId,
    this.medicineName,
    this.medicinePrice,
    this.discount,
    this.noOfOrders,
    this.noOfItemsAvailable,
    this.totalPrice,
  });

  OrderedItemsDto.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    medicineName = json['medicineName'];
    medicinePrice = json['medicinePrice'];
    discount = json['discount'];
    noOfOrders = json['noOfOrders'];
    noOfItemsAvailable = json['noOfItemsAvailable'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['medicineName'] = this.medicineName;
    data['medicinePrice'] = this.medicinePrice;
    data['discount'] = this.discount;
    data['noOfOrders'] = this.noOfOrders;
    data['noOfItemsAvailable'] = this.noOfItemsAvailable;
    data['totalPrice'] = this.totalPrice;

    return data;
  }
}
