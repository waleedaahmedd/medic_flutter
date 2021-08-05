import 'dart:convert';

import 'dart:ffi';

class CartDetailDTO {
  int itemId;
  double itemPriceWithoutQuantityAndDiscount;
  double itemPriceWithSingleQuantityAndDiscount;
  double itemPriceWithQuantityAndDiscount;
  int itemQuantity;
  int medicineId;
  String medicineName;
  String medicineIcon;
  String description;
  String manufacturer;
  int medicineQuantity;
  String medicineUnit;
  int discount;

  CartDetailDTO(
      {this.itemId,
      this.itemPriceWithoutQuantityAndDiscount,
      this.itemPriceWithSingleQuantityAndDiscount,
      this.itemPriceWithQuantityAndDiscount,
      this.itemQuantity,
      this.medicineId,
      this.medicineName,
      this.medicineIcon,
      this.description,
      this.manufacturer,
      this.medicineQuantity,
      this.medicineUnit,
      this.discount});

  CartDetailDTO.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemPriceWithoutQuantityAndDiscount =
        json['itemPriceWithoutQuantityAndDiscount'];
    itemPriceWithSingleQuantityAndDiscount =
        json['itemPriceWithSingleQuantityAndDiscount'];
    itemPriceWithQuantityAndDiscount = json['itemPriceWithQuantityAndDiscount'];
    itemQuantity = json['itemQuantity'];
    medicineId = json['medicineId'];
    medicineName = json['medicineName'];
    medicineIcon = json['medicineIcon'];
    description = json['description'];
    manufacturer = json['manufacturer'];
    medicineQuantity = json['medicineQuantity'];
    medicineUnit = json['medicineUnit'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemPriceWithoutQuantityAndDiscount'] =
        this.itemPriceWithoutQuantityAndDiscount;
    data['itemPriceWithSingleQuantityAndDiscount'] =
        this.itemPriceWithSingleQuantityAndDiscount;
    data['itemPriceWithQuantityAndDiscount'] =
        this.itemPriceWithQuantityAndDiscount;
    data['itemQuantity'] = this.itemQuantity;
    data['medicineId'] = this.medicineId;
    data['medicineName'] = this.medicineName;
    data['medicineIcon'] = this.medicineIcon;
    data['description'] = this.description;
    data['manufacturer'] = this.manufacturer;
    data['medicineQuantity'] = this.medicineQuantity;
    data['medicineUnit'] = this.medicineUnit;
    data['discount'] = this.discount;

    return data;
  }

  getImage() {
    String newDecodedImageUri = utf8
        .decode(base64.decode(this.medicineIcon))
        .replaceAll("data:image/png;base64,", "");

    return base64.decode(newDecodedImageUri);
  }
}
