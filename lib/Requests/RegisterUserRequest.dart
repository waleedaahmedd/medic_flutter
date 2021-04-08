class RegisterUserRequest {
  String firstName;
  String lastName;
  String phoneNumber;
  String roleName;
  String password;
  String emailAddress;

  RegisterUserRequest(
      {this.firstName,
        this.lastName,
        this.phoneNumber,
        this.roleName,
        this.password,
        this.emailAddress});

  RegisterUserRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    roleName = json['roleName'];
    password = json['password'];
    emailAddress = json['emailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['roleName'] = this.roleName;
    data['password'] = this.password;
    data['emailAddress'] = this.emailAddress;
    return data;
  }
}