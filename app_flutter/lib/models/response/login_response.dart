class LogiResponse {
  String? id;
  String? username;
  String? name;
  List<String>? roles;
  String? token;

  LogiResponse({this.id, this.username, this.name, this.roles, this.token});

  LogiResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    roles = json['roles'].cast<String>();
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['roles'] = this.roles;
    data['token'] = this.token;
    return data;
  }
}
