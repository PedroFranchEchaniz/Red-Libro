import 'package:app_flutter/blocs/array-book-bloc/bloc/book_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/repositories/arrayBooks/arrayBooks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Ya no necesitas crear una nueva instancia de BookBloc aquí
    // Simplemente añade el evento para comenzar a cargar los libros
    BlocProvider.of<BookBloc>(context).add(FetchBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return HorizontalList(
                    books: state.books[index]); // Pasa una lista de libros
              },
            );
          } else if (state is Error) {
            return Center(child: Text("Error al cargar los libros"));
          }
          return Center(child: Text("No hay libros disponibles"));
        },
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final List<Book> books;

  const HorizontalList({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 150,
            margin: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    book.portada ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Text('Sin imagen', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(book.titulo ?? "Sin título",
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 4),
                Text(book.autor ?? "Autor desconocido",
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        },
      ),
    );
  }
}
