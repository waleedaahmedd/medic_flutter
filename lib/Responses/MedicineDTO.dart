import 'dart:convert';

class MedicineDTO {
  int medicineId;
  String medicineName;
  int quantity;
  String unit;
  int price;
  int discount;
  String description;
  int qtyAvailable;
  String manufacturer;
  Null categoryName;
  Null categoryId;
  String image;
  double calculatedPrice;
  Null productExpiries;

  MedicineDTO(
      {this.medicineId,
        this.medicineName,
        this.quantity,
        this.unit,
        this.price,
        this.discount,
        this.description,
        this.qtyAvailable,
        this.manufacturer,
        this.categoryName,
        this.categoryId,
        this.image,
        this.calculatedPrice,
        this.productExpiries});

  MedicineDTO.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicineId'];
    medicineName = json['medicineName'];
    quantity = json['quantity'].truncate();
    unit = json['unit'];
    price = json['price'].truncate();
    discount = json['discount'].truncate();
    description = json['description'];
    qtyAvailable = json['qty_Available'];
    manufacturer = json['manufacturer'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    image = json['image'];
    calculatedPrice = json['calculatedPrice'];
    productExpiries = json['productExpiries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicineId'] = this.medicineId;
    data['medicineName'] = this.medicineName;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['qty_Available'] = this.qtyAvailable;
    data['manufacturer'] = this.manufacturer;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    data['image'] = this.image;
    data['calculatedPrice'] = this.calculatedPrice;
    data['productExpiries'] = this.productExpiries;
    return data;
  }

  getImage(){

    String newDecodedImageUri =  utf8.decode(base64.decode(this.image)).replaceAll("data:image/jpeg;base64,", "");

    return  base64.decode(newDecodedImageUri);


  }
}