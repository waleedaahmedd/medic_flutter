
class LoginUserResponse {
  String responseCode;
  String responseMessage;
  String jwtToken;
  Null userId;
  Null userName;
  String roleName;
  int cartItems;

  LoginUserResponse(
      {this.responseCode,
        this.responseMessage,
        this.jwtToken,
        this.userId,
        this.userName,
        this.roleName,
        this.cartItems});

  LoginUserResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    jwtToken = json['jwtToken'];
    userId = json['userId'];
    userName = json['userName'];
    roleName = json['roleName'];
    cartItems = json['cartItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['jwtToken'] = this.jwtToken;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['roleName'] = this.roleName;
    data['cartItems'] = this.cartItems;
    return data;
  }
}