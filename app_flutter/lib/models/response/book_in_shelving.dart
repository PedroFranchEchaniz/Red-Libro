class BookInShelvingResponse {
  String? isbn;
  String? titulo;
  String? portada;
  String? autor;
  int? valoracionMedia;

  BookInShelvingResponse(
      {this.isbn, this.titulo, this.portada, this.autor, this.valoracionMedia});

  BookInShelvingResponse.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    titulo = json['titulo'];
    portada = json['portada'];
    autor = json['autor'];
    valoracionMedia = json['valoracionMedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isbn'] = this.isbn;
    data['titulo'] = this.titulo;
    data['portada'] = this.portada;
    data['autor'] = this.autor;
    data['valoracionMedia'] = this.valoracionMedia;
    return data;
  }
}
