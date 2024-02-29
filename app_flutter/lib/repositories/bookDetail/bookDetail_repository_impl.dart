import 'dart:convert';

import 'package:app_flutter/models/response/book_detail_rating.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookDetailRepositoryImpl extends BookDetailRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<BookRating> getDetailBook(String isbn) async {
    String? token = await _storage.read(key: 'authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await _httpClient.get(
      Uri.parse('http://localhost:8080/book/$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return BookRating.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book detail');
    }
  }
}
