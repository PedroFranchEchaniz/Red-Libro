part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class ConfirmBookingEvent extends BookingEvent {
  final String shopUuid;
  final String bookIsbn;
  final String clientUuid;

  ConfirmBookingEvent(this.shopUuid, this.bookIsbn, this.clientUuid);
}
