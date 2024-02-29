class ConfirmBookingResponse {
  String? codigo;
  String? fechaReserva;
  String? fechaExpiacion;
  String? nombreUsuario;
  String? titulo;
  String? idbn;
  String? lat;
  String? lon;

  ConfirmBookingResponse(
      {this.codigo,
      this.fechaReserva,
      this.fechaExpiacion,
      this.nombreUsuario,
      this.titulo,
      this.idbn,
      this.lat,
      this.lon});

  ConfirmBookingResponse.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    fechaReserva = json['fechaReserva'];
    fechaExpiacion = json['fechaExpiacion'];
    nombreUsuario = json['nombreUsuario'];
    titulo = json['titulo'];
    idbn = json['idbn'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['fechaReserva'] = this.fechaReserva;
    data['fechaExpiacion'] = this.fechaExpiacion;
    data['nombreUsuario'] = this.nombreUsuario;
    data['titulo'] = this.titulo;
    data['idbn'] = this.idbn;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
