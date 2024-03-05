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
    BlocProvider.of<BookBloc>(context).add(FetchBooks());

    List<Widget> _widgetOptions = <Widget>[
      BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return BookListWidget(
                  books: state.books[index],
                  categoryIndex: index,
                );
              },
            );
          } else if (state is ErrorLoaded) {
            return Center(
                child: Text("Error al cargar los libros: ${state.errorMessage}",
                    style:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0))));
          }
          return Center(
              child: Text("No hay libros disponibles",
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))));
        },
      ),
      BlocProvider<LogesUserBloc>(
        create: (context) =>
            LogesUserBloc(userRepo: RegistedUserRepositoryImpl()),
        child: UserScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 90.0),
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
