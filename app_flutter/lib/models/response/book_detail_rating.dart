class BookRating {
  String? isbn;
  String? titulo;
  String? autor;
  String? editorial;
  String? fecha;
  String? fechaAlta;
  String? portada;
  String? genres;
  String? resumen;
  int? valoracion;
  bool? disponible;
  List<Valoraciones>? valoraciones;

  BookRating(
      {this.isbn,
      this.titulo,
      this.autor,
      this.editorial,
      this.fecha,
      this.fechaAlta,
      this.portada,
      this.genres,
      this.resumen,
      this.valoracion,
      this.disponible,
      this.valoraciones});

  BookRating.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    titulo = json['titulo'];
    autor = json['autor'];
    editorial = json['editorial'];
    fecha = json['fecha'];
    fechaAlta = json['fechaAlta'];
    portada = json['portada'];
    genres = json['genres'];
    resumen = json['resumen'];
    valoracion = json['valoracion'];
    disponible = json['disponible'];
    if (json['valoraciones'] != null) {
      valoraciones = <Valoraciones>[];
      json['valoraciones'].forEach((v) {
        valoraciones!.add(new Valoraciones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isbn'] = this.isbn;
    data['titulo'] = this.titulo;
    data['autor'] = this.autor;
    data['editorial'] = this.editorial;
    data['fecha'] = this.fecha;
    data['fechaAlta'] = this.fechaAlta;
    data['portada'] = this.portada;
    data['genres'] = this.genres;
    data['resumen'] = this.resumen;
    data['valoracion'] = this.valoracion;
    data['disponible'] = this.disponible;
    if (this.valoraciones != null) {
      data['valoraciones'] = this.valoraciones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Valoraciones {
  String? userName;
  int? valoracion;
  Null? comentario;

  Valoraciones({this.userName, this.valoracion, this.comentario});

  Valoraciones.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    valoracion = json['valoracion'];
    comentario = json['comentario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['valoracion'] = this.valoracion;
    data['comentario'] = this.comentario;
    return data;
  }
}
