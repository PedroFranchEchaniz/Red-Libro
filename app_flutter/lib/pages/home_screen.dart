import 'package:app_flutter/widget/book-list-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/array-book-bloc/bloc/book_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
// Asegúrate de importar el widget BookListWidget aquí

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
                // Aquí utilizamos el widget BookListWidget para cada categoría
                return BookListWidget(
                  books: nonEmptyCategories[categoryIndex],
                  categoryIndex: categoryIndex,
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
