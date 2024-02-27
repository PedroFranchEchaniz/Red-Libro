part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class GetShopsWithBook extends ShopEvent {
  final String isbn;

  GetShopsWithBook(this.isbn);
}
