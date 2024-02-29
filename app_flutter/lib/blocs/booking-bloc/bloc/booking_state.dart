part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoad extends BookingState {
  final ConfirmBookingResponse booking;
  BookingLoad(this.booking);
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}
