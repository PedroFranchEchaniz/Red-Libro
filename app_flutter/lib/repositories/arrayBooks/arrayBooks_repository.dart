import 'package:app_flutter/models/response/array_films_response.dart';

abstract class ArrayBooksRepository {
  Future<ArrayBooksResponse> getArrayBooks();
  Future<ArrayBooksResponse> fetchBookDetails(String isbn);
}
