import 'package:app_flutter/models/response/user_shelving_response.dart';

abstract class ShelvingRepository {
  Future<UserShelvingResponse> addToShelving(String isbn);
}
