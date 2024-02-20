class RegisterDto {
  String? username;
  String? password;
  String? verifyPassword;
  String? lastName;
  String? name;

  RegisterDto(
      {this.username,
      this.password,
      this.verifyPassword,
      this.lastName,
      this.name});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
    lastName = json['lastName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['verifyPassword'] = this.verifyPassword;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    return data;
  }
}
