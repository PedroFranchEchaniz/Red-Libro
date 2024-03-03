import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/blocs/array-book-bloc/bloc/book_bloc.dart';
import 'package:app_flutter/widget/book-list-widget.dart';
import 'package:app_flutter/blocs/User-loged-bloc/bloc/loges_user_bloc.dart';
import 'package:app_flutter/widget/user_screen.dart';
import 'package:app_flutter/repositories/userRegisted/user_registed_repository_impl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Inicializamos el BookBloc si no ha sido inicializado antes
    BlocProvider.of<BookBloc>(context).add(FetchBooks());

    List<Widget> _widgetOptions = <Widget>[
      // Mantenemos la implementación original para la lista de libros
      BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                // Asegúrate de que esta parte coincide con tu implementación que funcionaba anteriormente
                return BookListWidget(
                  books: state.books[index],
                  categoryIndex: index,
                );
              },
            );
          } else if (state is ErrorLoaded) {
            return Center(
                child: Text("Error al cargar los libros: ${state.errorMessage}",
                    style: TextStyle(color: Colors.white)));
          }
          return Center(
              child: Text("No hay libros disponibles",
                  style: TextStyle(color: Colors.white)));
        },
      ),
      // Integración de la funcionalidad del usuario
      BlocProvider<LogesUserBloc>(
        create: (context) =>
            LogesUserBloc(userRepo: RegistedUserRepositoryImpl()),
        child: UserScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Libros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
