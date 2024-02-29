import 'package:app_flutter/models/response/confirm_booking_response.dart';
import 'package:app_flutter/repositories/booking/booking_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<ConfirmBookingEvent>((event, emit) async {
      try {
        final ConfirmBookingResponse booking = await bookingRepository.booking(
            event.shopUuid, event.bookIsbn, event.clientUuid);
        emit(BookingLoad(booking));
      } catch (e) {
        emit(BookingError(e.toString()));
      }
    });
  }
}
