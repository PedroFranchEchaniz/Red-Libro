part of 'book_bloc.dart';

@immutable
sealed class BookState {}

class Initial extends BookState {}

class Loading extends BookState {}

class Loaded extends BookState {
  final List<List<Book>> books;

  Loaded({required this.books});
}

class ErrorLoaded extends BookState {
  final String errorMessage;
  ErrorLoaded(this.errorMessage);
}
