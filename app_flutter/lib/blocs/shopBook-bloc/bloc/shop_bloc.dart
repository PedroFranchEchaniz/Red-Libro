import 'package:app_flutter/models/response/shops_with_book_response.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopWithBookRepository shopWithBookRepository;

  ShopBloc({required this.shopWithBookRepository}) : super(ShopsInitial()) {
    on<GetShopsWithBook>((event, emit) async {
      print('Procesando evento GetShopsWithBook con ISBN: ${event.isbn}');
      emit(ShopsLoading());
      print('Estado emitido: ShopsLoading');
      try {
        final List<ShopsWithBookResponse> shops =
            await shopWithBookRepository.getShopWithBook(event.isbn);
        print('Tiendas cargadas: $shops');
        emit(ShopsLoaded(shops));
        print('Estado emitido: ShopsLoaded');
      } catch (e) {
        print('Error al cargar tiendas: $e');
        emit(ShopsError(e.toString()));
        print('Estado emitido: ShopsError');
      }
    });
  }
}
