class ShopsWithBookResponse {
  String? name;
  String? direccion;
  String? lat;
  String? lon;

  ShopsWithBookResponse({this.name, this.direccion, this.lat, this.lon});

  ShopsWithBookResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    direccion = json['direccion'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['direccion'] = this.direccion;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
