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
      emit(ShopsLoading());
      try {
        final List<ShopsWithBookResponse> shops =
            await shopWithBookRepository.getShopWithBook(event.isbn);
        emit(ShopsLoaded(shops));
      } catch (e) {
        emit(ShopsError(e.toString()));
      }
    });
  }
}
