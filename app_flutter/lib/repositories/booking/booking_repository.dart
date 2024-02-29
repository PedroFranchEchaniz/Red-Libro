import 'package:app_flutter/models/response/confirm_booking_response.dart';

abstract class BookingRepository {
  Future<ConfirmBookingResponse> booking(
      String shopUuid, String bookIsbn, String clientUuid);
}
