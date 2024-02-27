import 'dart:convert';

import 'package:app_flutter/models/response/array_films_response.dart';
import 'package:app_flutter/repositories/arrayBooks/arrayBooks_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArrayBooksRepositoryImpl extends ArrayBooksRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<ArrayBooksResponse> fetchBookDetails(String isbn) {
    throw UnimplementedError();
  }

  @override
  Future<ArrayBooksResponse> getArrayBooks() async {
    // Leer el token almacenado
    String? token = await _storage.read(key: 'authToken');

    // Si no hay token, lanza una excepción o maneja el caso como consideres necesario
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await _httpClient.get(
      Uri.parse('http://10.0.2.2:8080/book/listsBooks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Usa el token leído
      },
    );

    if (response.statusCode == 200) {
      return ArrayBooksResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load books');
    }
  }
}
