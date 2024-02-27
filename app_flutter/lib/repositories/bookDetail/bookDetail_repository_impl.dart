import 'dart:convert';

import 'package:app_flutter/models/response/book_detail_rating.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository.dart';
import 'package:http/http.dart';

class BookDetailRepositoryImpl extends BookDetailRepository {
  final Client _httpClient = Client();

  @override
  Future<BookRating> getDetailBook(String isbn) async {
    final response = await _httpClient.get(
        Uri.parse('http://localhost:8080/book/$isbn'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjNGUyNzE3My01MmI1LTRiZDktOTRlZS04OGEwNzE2N2ZhNzIiLCJpYXQiOjE3MDg2MjMxNDMsImV4cCI6MTcwOTIyNzk0M30.MCK6MDKMS0NCMYYnClIPZn2A2VC4-fHrBV4sJYQ4wh360CE-0M1mLXwTpzbc7i5Xb0gOMG2XNvPbKYyFsqXA5Q',
        });
    if (response.statusCode == 200) {
      return BookRating.fromJson(json.decode(response.body));
    } else {
      throw Exception(('Whats happening here'));
    }
  }
}
