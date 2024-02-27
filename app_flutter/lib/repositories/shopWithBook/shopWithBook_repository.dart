import 'package:app_flutter/models/response/shops_with_book_response.dart';

abstract class ShopWithBookRepository {
  Future<List<ShopsWithBookResponse>> getShopWithBook(String isbn);
}
