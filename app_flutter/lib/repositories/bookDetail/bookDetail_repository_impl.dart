import 'dart:convert';

import 'package:app_flutter/models/dto/rating_dto.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/models/response/rating_response.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookDetailRepositoryImpl extends BookDetailRepository {
  final Client _httpClient = Client();
  final _storage = FlutterSecureStorage();

  @override
  Future<Book> getDetailBook(String isbn) async {
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
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book detail');
    }
  }

  @override
  Future<RatingResponse> newRating(String isbn, RatingDto ratingDto) async {
    String? token = await _storage.read(key: 'authToken');

    if (token == null) {
      throw Exception('Authorization token not found');
    }
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/book/rating/$isbn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(ratingDto.toJson()),
    );
    if (response.statusCode == 201) {
      return RatingResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to do login');
    }
  }
}
