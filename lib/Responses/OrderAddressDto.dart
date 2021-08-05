import 'dart:ffi';

class OrderAddressDto {
  String city;
  String country;
  String nearByLocation;
  String houseNumber;
  Double lattitude;
  Double longitude;
  String phoneNumber;
  String receiverName;

  OrderAddressDto(
      {this.city,
      this.country,
      this.nearByLocation,
      this.houseNumber,
      this.lattitude,
      this.longitude,
      this.phoneNumber,
      this.receiverName});

  OrderAddressDto.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    nearByLocation = json['nearByLocation'];
    houseNumber = json['houseNumber'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    phoneNumber = json['phoneNumber'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['nearByLocation'] = this.nearByLocation;
    data['houseNumber'] = this.houseNumber;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['phoneNumber'] = this.phoneNumber;
    data['receiverName'] = this.receiverName;
    return data;
  }
}
