import 'package:app_flutter/models/response/book_detail_rating.dart';

abstract class BookDetailRepository {
  Future<BookRating> getDetailBook(String isbn);
}
