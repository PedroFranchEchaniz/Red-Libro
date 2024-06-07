import 'package:app_flutter/models/response/registed_user_response.dart';
import 'package:app_flutter/repositories/userRegisted/user_registed_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RegistedUserRepositoryImpl extends RegistedUserRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<RegistedUserResponse> getRegistedUser() async {
    String? token = await _storage.read(key: 'authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await _httpClient.get(
        Uri.parse('http://10.0.2.2:8080/client/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      return RegistedUserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ueeeepa');
    }
  }

  @override
  Future<void> deleteBooking(
      String bookingUuid, String bookIsbn, String shopUuid) async {
    String? token = await _storage.read(key: 'authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final url =
        'http://10.0.2.2:8080/shopBooking/delete/$bookingUuid?bookisbn=$bookIsbn&shopUuid=$shopUuid';

    print('URL: $url');
    print('Token: $token');

    try {
      final response = await _httpClient.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Reserva eliminada con éxito');
      } else {
        print(
            'Error al eliminar la reserva - Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
    }
  }
}
