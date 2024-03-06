import 'package:app_flutter/models/dto/rating_dto.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/models/response/rating_response.dart';

abstract class BookDetailRepository {
  Future<Book> getDetailBook(String isbn);
  Future<RatingResponse> newRating(String isbn, RatingDto ratingDto);
}
