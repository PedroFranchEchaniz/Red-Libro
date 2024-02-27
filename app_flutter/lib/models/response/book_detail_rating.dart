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
      this.disponible});

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
    return data;
  }
}
