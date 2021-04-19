import 'dart:convert';

class CategoryDTO {
  String categoryName;
  String categoryIcon;
  int id;

  CategoryDTO({this.categoryName, this.categoryIcon, this.id});

  CategoryDTO.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryIcon = json['categoryIcon'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['categoryIcon'] = this.categoryIcon;
    data['id'] = this.id;
    return data;
  }
  getImage(){

    String newDecodedImageUri =  utf8.decode(base64.decode(this.categoryIcon)).replaceAll("data:image/png;base64,", "");

    return  base64.decode(newDecodedImageUri);


  }
}