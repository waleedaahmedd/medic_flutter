class AddToCartRequest {
  int medicineId;
  String quantity;

  AddToCartRequest({this.medicineId, this.quantity});

  AddToCartRequest.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicineId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicineId'] = this.medicineId;
    data['quantity'] = this.quantity;
    return data;
  }
}
