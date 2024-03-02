class RegistedUserResponse {
  String? uuid;
  String? name;
  String? lastName;
  String? avatar;
  String? username;

  RegistedUserResponse(
      {this.uuid, this.name, this.lastName, this.avatar, this.username});

  RegistedUserResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    return data;
  }
}
