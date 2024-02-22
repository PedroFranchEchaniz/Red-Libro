import 'package:app_flutter/blocs/array-book-bloc/bloc/book_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
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
    BlocProvider.of<BookBloc>(context).add(FetchBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            // Filtrar categorías vacías antes de construir los widgets
            final nonEmptyCategories =
                state.books.where((category) => category.isNotEmpty).toList();

            return ListView.builder(
              itemCount: nonEmptyCategories
                  .length, // Usar el tamaño de la lista filtrada
              itemBuilder: (context, categoryIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Categoría ${categoryIndex + 1}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nonEmptyCategories[categoryIndex]
                            .length, // Número de libros en la categoría
                        itemBuilder: (context, index) {
                          final book = nonEmptyCategories[categoryIndex][index];
                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      book.portada ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        color: Colors.grey[200],
                                        alignment: Alignment.center,
                                        child: Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(book.titulo ?? "Sin título",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 235, 230, 230))),
                                SizedBox(height: 4),
                                Text(book.autor ?? "Autor desconocido",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600])),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is ErrorLoaded) {
            return Center(
              child: Text("Error al cargar los libros: ${state.errorMessage}"),
            );
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
        itemCount: books.length, // Número de libros en la categoría
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 120,
            margin: EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      book.portada ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(book.titulo ?? "Sin título",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 4),
                Text(book.autor ?? "Autor desconocido",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600])),
              ],
            ),
          );
        },
      ),
    );
  }
}
