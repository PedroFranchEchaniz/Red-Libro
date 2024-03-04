import 'package:app_flutter/models/response/book_detail_rating.dart';
import 'package:app_flutter/models/response/book_response.dart';

abstract class BookDetailRepository {
  Future<Book> getDetailBook(String isbn);
}
