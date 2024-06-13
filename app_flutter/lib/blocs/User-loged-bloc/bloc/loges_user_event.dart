part of 'loges_user_bloc.dart';

@immutable
sealed class LogesUserEvent {}

class FetchUser extends LogesUserEvent {}

class DeleteBooking extends LogesUserEvent {
  final String bookingUuid;
  final String bookIsbn;
  final String shopUuid;

  DeleteBooking(this.bookingUuid, this.bookIsbn, this.shopUuid);
}

class DeleteShelving extends LogesUserEvent {
  final String isbn;

  DeleteShelving(this.isbn);
}
