import 'dart:convert';

import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository.dart';
import 'package:http/http.dart';

class ShopWithBookRepositoryImpl extends ShopWithBookRepository {
  final Client _httpClient = Client();

  @override
  Future<List<ShopsWithBookResponse>> getShopWithBook(String isbn) async {
    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/book/avaibleInShop/$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzZmZmODVjZS0zNTRiLTRlNGMtYmJjMy03Y2UxMzhlNTczYjYiLCJpYXQiOjE3MDkwNjA4MzQsImV4cCI6MTcwOTY2NTYzNH0.ec9byOrFjde6zE9mvjtQwmUFLYwI6y5jbAEOlxSHhxSGLLtNeG39B8ktwufdtIHEPP89oLC2mfMM3ZMNZXMvug',
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
