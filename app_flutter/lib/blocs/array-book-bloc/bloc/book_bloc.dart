import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/repositories/arrayBooks/arrayBooks_repository.dart';

part 'book_event.dart'; // Asegúrate de que esta parte define el evento FetchBooks correctamente
part 'book_state.dart'; // Asegúrate de que esta parte define los estados correctamente

class BookBloc extends Bloc<BookEvent, BookState> {
  final ArrayBooksRepository _arrayBooksRepository;

  BookBloc(this._arrayBooksRepository) : super(Initial()) {
    on<FetchBooks>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    emit(Loading());
    try {
      final response = await _arrayBooksRepository.getArrayBooks();
      emit(Loaded(
          books: response
              .books)); // Asegúrate de que Loaded acepte un parámetro nombrado 'books'
    } catch (_) {
      emit(ErrorLoaded(
          "Error loading books")); // Cambia el nombre del estado si es necesario
    }
  }
}
