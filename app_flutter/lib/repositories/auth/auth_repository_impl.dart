import 'dart:convert';

import 'package:app_flutter/models/dto/login_dto.dart';
import 'package:http/http.dart';

import 'package:app_flutter/models/response/login_response.dart';
import 'package:app_flutter/repositories/auth/auth_repositori.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LogiResponse> login(LoginDto loginDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/client/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginDto.toJson()),
    );
    if (response.statusCode == 201) {
      return LogiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to do login');
    }
  }
}
