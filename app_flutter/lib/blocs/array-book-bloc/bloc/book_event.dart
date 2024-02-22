part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class FetchBooks extends BookEvent {}

class ToggleBookDetails extends BookEvent {
  final int index;

  ToggleBookDetails(this.index);
}
