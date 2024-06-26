import 'package:app_flutter/models/response/registed_user_response.dart';

abstract class RegistedUserRepository {
  Future<RegistedUserResponse> getRegistedUser();
  Future<void> deleteBooking(
      String bookingUuid, String bookIsbn, String shopUuid);
  Future<void> deleteShelving(String isbn);
}
