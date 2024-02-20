class RegisterResponse {
  String? id;
  String? username;
  String? name;
  String? lastName;
  List<String>? roles;

  RegisterResponse(
      {this.id, this.username, this.name, this.lastName, this.roles});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    lastName = json['lastName'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['roles'] = this.roles;
    return data;
  }
}
