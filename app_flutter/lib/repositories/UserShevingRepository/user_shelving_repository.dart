import 'package:app_flutter/models/response/book_in_shelving.dart';
import 'package:app_flutter/models/response/user_shelving_response.dart';

abstract class ShelvingRepository {
  Future<UserShelvingResponse> addToShelving(String isbn);
  Future<bool> bookIsInShelving(String isbn);
  Future<BookInShelvingResponse> getBooksInShelving();
}
