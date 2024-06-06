class RegistedUserResponse {
  String? uuid;
  String? name;
  String? lastName;
  String? avatar;
  String? username;
  List<Booking>? booking;
  List<Shelving>? shelving;

  RegistedUserResponse(
      {this.uuid,
      this.name,
      this.lastName,
      this.avatar,
      this.username,
      this.booking,
      this.shelving});

  RegistedUserResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    username = json['username'];
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
    if (json['shelving'] != null) {
      shelving = <Shelving>[];
      json['shelving'].forEach((v) {
        shelving!.add(new Shelving.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    if (this.shelving != null) {
      data['shelving'] = this.shelving!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? uuidShop;
  String? uuid;
  String? codigo;
  String? fechaReserva;
  String? fechaExpiacion;
  String? nombreUsuario;
  String? titulo;
  String? portada;
  String? idbn;
  String? lat;
  String? lon;

  Booking(
      {this.uuidShop,
      this.uuid,
      this.codigo,
      this.fechaReserva,
      this.fechaExpiacion,
      this.nombreUsuario,
      this.titulo,
      this.portada,
      this.idbn,
      this.lat,
      this.lon});

  Booking.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    fechaReserva = json['fechaReserva'];
    fechaExpiacion = json['fechaExpiacion'];
    nombreUsuario = json['nombreUsuario'];
    titulo = json['titulo'];
    portada = json['portada'];
    idbn = json['idbn'];
    lat = json['lat'];
    lon = json['lon'];
    uuid = json['uuid'];
    uuidShop = json['uuidShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['fechaReserva'] = this.fechaReserva;
    data['fechaExpiacion'] = this.fechaExpiacion;
    data['nombreUsuario'] = this.nombreUsuario;
    data['titulo'] = this.titulo;
    data['portada'] = this.portada;
    data['idbn'] = this.idbn;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Shelving {
  String? titulo;
  String? portada;
  String? autor;
  double? valoracionMedia;

  Shelving({this.titulo, this.portada, this.autor, this.valoracionMedia});

  Shelving.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    portada = json['portada'];
    autor = json['autor'];
    valoracionMedia = json['valoracionMedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['portada'] = this.portada;
    data['autor'] = this.autor;
    data['valoracionMedia'] = this.valoracionMedia;
    return data;
  }
}
