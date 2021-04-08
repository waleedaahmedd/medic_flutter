import 'CategoryDTO.dart';

class CategoryListResponse {
  String responseCode;
  String responseMessage;
  List<CategoryDTO> categories;

  CategoryListResponse({this.responseCode, this.responseMessage, this.categories});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['categories'] != null) {
      categories = new List<CategoryDTO>();
      json['categories'].forEach((v) {
        categories.add(new CategoryDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
