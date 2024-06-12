import 'package:app_flutter/repositories/allBooks/allbooks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';

import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final AllBooksRepository _allBooksRepository;

  BookBloc(this._allBooksRepository) : super(Initial()) {
    on<FetchBooks>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(FetchBooks event, Emitter<BookState> emit) async {
    emit(Loading());
    try {
      final response = await _allBooksRepository.getAllBooks(
        titulo: event.titulo,
        autor: event.autor,
        editorial: event.editorial,
        disponible: event.disponible,
        genre: event.genre,
      );

      emit(Loaded(books: response)); // Emitir el estado con los libros cargados
    } catch (_) {
      emit(ErrorLoaded("Error loading books")); // Manejar errores
    }
  }
}
