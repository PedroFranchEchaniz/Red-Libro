import 'package:flutter/material.dart';

@immutable
abstract class BookEvent {}

class FetchBooks extends BookEvent {
  final String? titulo;
  final String? autor;
  final String? editorial;
  final bool? disponible;
  final String? genre;

  FetchBooks({
    this.titulo,
    this.autor,
    this.editorial,
    this.disponible,
    this.genre,
  });
}

class BookViewDetail extends BookEvent {
  final int index;

  BookViewDetail(this.index);
}
