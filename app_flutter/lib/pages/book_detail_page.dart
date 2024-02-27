import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/shops_maps_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopsLoaded) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShopsMapPage(shops: state.shops),
              ),
            );
          } else if (state is ShopsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.portada ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                      Colors.black,
                    ],
                    stops: [0.0, 0.3, 0.5],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.portada ?? '',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    RatingBarIndicator(
                      rating: book.valoracion ?? 0.0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 24.0,
                      direction: Axis.horizontal,
                    ),
                    Text(
                      book.titulo ?? "Sin título",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Autor: ${book.autor ?? "Autor desconocido"}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Aquí puedes añadir el log para depurar
                          print(
                              'Enviando evento GetShopsWithBook con ISBN: ${book.isbn}');
                          // Ahora, envías el evento al Bloc
                          BlocProvider.of<ShopBloc>(context)
                              .add(GetShopsWithBook(book.isbn!));
                        },
                        child: Text('Reserva'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        book.resumen ?? "Resumen no disponible",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
