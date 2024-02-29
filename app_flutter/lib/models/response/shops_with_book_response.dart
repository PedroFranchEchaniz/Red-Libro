class ShopsWithBookResponse {
  String? name;
  String? direccion;
  String? lat;
  String? lon;
  double? precio;
  String? uuid;

  ShopsWithBookResponse(
      {this.name, this.direccion, this.lat, this.lon, this.uuid, this.precio});

  ShopsWithBookResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    direccion = json['direccion'];
    lat = json['lat'];
    lon = json['lon'];
    precio = json['precio'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['direccion'] = this.direccion;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['precio'] = this.precio;
    data['uuid'] = this.uuid;
    return data;
  }
}
