part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class FetchBooks extends BookEvent {}

class BookViewDetail extends BookEvent {
  final int index;

  BookViewDetail(this.index);
}
