class Book {
  String? isbn;
  String? titulo;
  String? autor;
  String? editorial;
  String? fecha;
  String? fechaAlta;
  String? portada;
  String? generos;
  String? resumen;
  double? valoracion;
  bool? disponible;

  Book(
      {this.isbn,
      this.titulo,
      this.autor,
      this.editorial,
      this.fecha,
      this.fechaAlta,
      this.portada,
      this.generos,
      this.resumen,
      this.valoracion,
      this.disponible});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        isbn: json['isbn'],
        titulo: json['titulo'],
        autor: json['autor'],
        editorial: json['editorial'],
        fecha: json['fecha'],
        fechaAlta: json['fechaAlta'],
        portada: json['portada'],
        generos: json['generos'],
        resumen: json['resumen'],
        valoracion: json['valoracion'],
        disponible: json['disponible']);
  }

  Map<String, dynamic> toJson() {
    return {
      'isbn': isbn,
      'titulo': titulo,
      'autor': autor,
      'editorial': editorial,
      'fecha': fecha,
      'fechaAlta': fechaAlta,
      'portada': portada,
      'generos': generos,
      'resumen': resumen,
      'valoracion': valoracion,
      'disponible': disponible
    };
  }
}
