import 'dart:convert';

import 'package:app_flutter/models/dto/register_dto.dart';
import 'package:app_flutter/models/response/register_response.dart';
import 'package:app_flutter/repositories/register/register_repositori.dart';
import 'package:http/http.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final Client _httpClient = Client();

  @override
  Future<RegisterResponse> register(RegisterDto registerDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://localhost:8080/client/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(registerDto.toJson()),
    );
    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed register');
    }
  }
}
