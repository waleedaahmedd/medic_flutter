class RegisterUserResponse {
  String responseCode;
  String responseMessage;
  int userId;

  RegisterUserResponse({this.responseCode, this.responseMessage, this.userId});

  RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['userId'] = this.userId;
    return data;
  }
}