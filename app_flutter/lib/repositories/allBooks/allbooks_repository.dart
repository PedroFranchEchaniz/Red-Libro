import 'package:app_flutter/models/response/book_response.dart';

abstract class AllBooksRepository {
  Future<List<Book>> getAllBooks({
    String? titulo,
    String? autor,
    String? editorial,
    bool? disponible,
    String? genre,
  });
}
