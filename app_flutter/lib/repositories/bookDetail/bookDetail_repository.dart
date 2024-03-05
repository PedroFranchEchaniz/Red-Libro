import 'package:app_flutter/models/response/book_response.dart';

abstract class BookDetailRepository {
  Future<Book> getDetailBook(String isbn);
}
