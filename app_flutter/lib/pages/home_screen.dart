import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/array-book-bloc/bloc/book_bloc.dart';
import 'package:app_flutter/widget/book-list-widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookBloc>(context).add(FetchBooks());
    _widgetOptions = <Widget>[
      // La pantalla de libros se construye aquí
      BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            final nonEmptyCategories =
                state.books.where((category) => category.isNotEmpty).toList();
            return ListView.builder(
              itemCount: nonEmptyCategories.length,
              itemBuilder: (context, categoryIndex) {
                return BookListWidget(
                  books: nonEmptyCategories[categoryIndex],
                  categoryIndex: categoryIndex,
                );
              },
            );
          } else if (state is ErrorLoaded) {
            return Center(
              child: Text(
                "Error al cargar los libros: ${state.errorMessage}",
                style: TextStyle(
                    color: Colors
                        .white), // Asegura visibilidad contra fondo oscuro
              ),
            );
          }
          return Center(
            child: Text("No hay libros disponibles",
                style: TextStyle(color: Colors.white)),
          );
        },
      ),
      // Otro widget para el segundo ítem de la barra de navegación
      Center(
          child: Text('Otra pantalla', style: TextStyle(color: Colors.white))),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        // Muestra el widget basado en _selectedIndex
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Libros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Otra pantalla',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
