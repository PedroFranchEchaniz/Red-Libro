import 'dart:convert';

import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopWithBookRepositoryImpl extends ShopWithBookRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<List<ShopsWithBookResponse>> getShopWithBook(String isbn) async {
    // Leer el token almacenado
    String? token = await _storage.read(key: 'authToken');

    // Si no hay token, lanza una excepción o maneja el caso como consideres necesario
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await _httpClient.get(
      Uri.parse('http://10.0.2.2/book/avaibleInShop/$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token', // Usa el token leído
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => ShopsWithBookResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load shops');
    }
  }
}
