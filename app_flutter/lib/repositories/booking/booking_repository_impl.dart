import 'package:app_flutter/models/response/confirm_booking_response.dart';
import 'package:app_flutter/repositories/booking/booking_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class BookingRepositoryImpl implements BookingRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<ConfirmBookingResponse> booking(
      String shopUuid, String bookIsbn, String clientUuid) async {
    String? token = await _storage.read(key: 'authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final Uri uri = Uri.parse(
        'http://10.0.2.2:8080/booking/$shopUuid/$bookIsbn/$clientUuid');

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ConfirmBookingResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('ops');
    }
  }
}
