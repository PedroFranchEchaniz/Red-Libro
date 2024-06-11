import 'package:flutter/material.dart';
import 'package:app_flutter/models/response/book_response.dart';

@immutable
abstract class BookState {}

class Initial extends BookState {}

class Loading extends BookState {}

class Loaded extends BookState {
  final List<Book> books;

  Loaded({required this.books});
}

class ErrorLoaded extends BookState {
  final String errorMessage;

  ErrorLoaded(this.errorMessage);
}
