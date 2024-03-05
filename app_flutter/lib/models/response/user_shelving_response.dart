class UserShelvingResponse {
  String? isbn;
  String? clientUuid;
  String? fechaAlta;
  String? titulo;
  String? portada;

  UserShelvingResponse(
      {this.isbn, this.clientUuid, this.fechaAlta, this.titulo, this.portada});

  UserShelvingResponse.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    clientUuid = json['clientUuid'];
    fechaAlta = json['fechaAlta'];
    titulo = json['titulo'];
    portada = json['portada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isbn'] = this.isbn;
    data['clientUuid'] = this.clientUuid;
    data['fechaAlta'] = this.fechaAlta;
    data['titulo'] = this.titulo;
    data['portada'] = this.portada;
    return data;
  }
}
