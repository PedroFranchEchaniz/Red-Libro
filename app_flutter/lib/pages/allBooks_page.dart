import 'package:app_flutter/repositories/allBooks/allbooks_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/book_detail_page.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository_impl.dart';
import 'package:app_flutter/blocs/book-bloc/book_bloc.dart';
import 'package:app_flutter/blocs/book-bloc/book_event.dart';
import 'package:app_flutter/blocs/book-bloc/book_state.dart';

import '../repositories/allBooks/allbooks_repository.dart'; // Importa tu bloc aquí

class AllBooksPage extends StatefulWidget {
  @override
  _AllBooksPageState createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
  final AllBooksRepository _repository = AllBooksRepositoryImpl();
  late BookBloc _bookBloc; // Declara tu bloc

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _editorialController = TextEditingController();

  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _bookBloc = BookBloc(_repository); // Inicializa tu bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos los Libros'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _autorController,
            decoration: InputDecoration(labelText: 'Autor'),
          ),
          TextField(
            controller: _editorialController,
            decoration: InputDecoration(labelText: 'Editorial'),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            child: Text('Buscar'),
          ),
          Expanded(
            child: _buildBooksGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksGrid() {
    return BlocBuilder<BookBloc, BookState>(
      bloc: _bookBloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          _filteredBooks = state.books;
        } else if (state is ErrorLoaded) {
          return Center(child: Text(state.errorMessage));
        }

        return _filteredBooks.isEmpty
            ? Center(child: Text('No se encontraron libros.'))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = _filteredBooks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                          book: book,
                          bookDetailRepository: BookDetailRepositoryImpl(),
                        ),
                      ));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                book.portada ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/image.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              book.titulo ?? "Sin título",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              book.autor ?? "Autor desconocido",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void _performSearch() {
    String? titulo =
        _tituloController.text.isNotEmpty ? _tituloController.text : null;
    String? autor =
        _autorController.text.isNotEmpty ? _autorController.text : null;
    String? editorial =
        _editorialController.text.isNotEmpty ? _editorialController.text : null;

    _bookBloc.add(FetchBooks(
      titulo: titulo,
      autor: autor,
      editorial: editorial,
      disponible: null,
      genre: null,
    ));
  }

  @override
  void dispose() {
    _bookBloc.close(); // Cierra tu bloc
    super.dispose();
  }
}
