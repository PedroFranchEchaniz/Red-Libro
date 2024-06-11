import 'dart:convert';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/repositories/allBooks/allbooks_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AllBooksRepositoryImpl implements AllBooksRepository {
  final _storage = FlutterSecureStorage();

  @override
  Future<List<Book>> getAllBooks({
    String? titulo,
    String? autor,
    String? editorial,
    bool? disponible,
    String? genre,
  }) async {
    String? token = await _storage.read(key: 'authToken');
    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final Uri uri = Uri.parse('http://10.0.2.2:8080/book/filter').replace(
      queryParameters: {
        'titulo': titulo ?? '',
        'autor': autor ?? '',
        'editorial': editorial ?? '',
        'disponible': disponible?.toString() ?? '',
        'genre': genre ?? '',
      },
    );

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Book> books = data.map((model) => Book.fromJson(model)).toList();
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
