part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopsInitial extends ShopState {}

class ShopsLoading extends ShopState {}

class ShopsLoaded extends ShopState {
  final List<ShopsWithBookResponse> shops;

  ShopsLoaded(this.shops) {
    print('ShopsLoaded creado con ${shops.length} tiendas');
  }
}

class ShopsError extends ShopState {
  final String message;

  ShopsError(this.message) {
    print('ShopsError creado con mensaje: $message');
  }
}
