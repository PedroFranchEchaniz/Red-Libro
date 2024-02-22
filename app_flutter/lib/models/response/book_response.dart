class Book {
  String? titulo;
  String? autor;
  String? editorial;
  String? fecha;
  String? fechaAlta;
  String? portada;

  Book(
      {this.titulo,
      this.autor,
      this.editorial,
      this.fecha,
      this.fechaAlta,
      this.portada});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        titulo: json['titulo'],
        autor: json['autor'],
        editorial: json['editorial'],
        fecha: json['fecha'],
        fechaAlta: json['fechaAlta'],
        portada: json['portada']);
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'autor': autor,
      'editorial': editorial,
      'fecha': fecha,
      'fechaAlta': fechaAlta,
      'portada': portada,
    };
  }
}
