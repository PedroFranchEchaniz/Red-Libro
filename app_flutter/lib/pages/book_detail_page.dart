import 'package:app_flutter/repositories/UserShevingRepository/user_shelving_repository.dart';
import 'package:app_flutter/repositories/UserShevingRepository/user_shelving_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/shops_maps_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  final ShelvingRepositoryImpl shelvingRepository = ShelvingRepositoryImpl();

  BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopsLoaded) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ShopsMapPage(shops: state.shops, book: book),
            ));
          } else if (state is ShopsError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                book.portada ?? '',
                fit: BoxFit.cover,
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
                      Colors.black.withOpacity(1)
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 20), // Espacio adicional en la parte superior
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.portada ?? '',
                        width: MediaQuery.of(context).size.width *
                            0.6, // Ajuste de tamaño para la portada en el contenido
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20), // Espacio después de la portada
                    Text(book.titulo ?? "Sin título",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 10), // Espacio antes del autor
                    Text("Autor: ${book.autor ?? "Autor desconocido"}",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(height: 20), // Espacio antes del botón de reserva
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ShopBloc>(context)
                                .add(GetShopsWithBook(book.isbn!));
                          },
                          child: Text('Reserva'),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.bookmark_add, color: Colors.blue),
                          onPressed: () async {
                            try {
                              await shelvingRepository
                                  .addToShelving(book.isbn!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Libro añadido a tu estantería')));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Error al añadir el libro')));
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(book.resumen ?? "Resumen no disponible",
                          style:
                              TextStyle(fontSize: 16, color: Colors.white70)),
                    ),
                    if (book.valoraciones == null ||
                        book.valoraciones!.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('No hay valoraciones disponibles',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70)),
                      )
                    ] else ...[
                      Container(
                        height: 200, // Ajusta este valor según necesites
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: book.valoraciones?.length ?? 0,
                          itemBuilder: (context, index) {
                            final valoracion = book.valoraciones![index];
                            return Container(
                              width: 200, // Ajusta este valor según necesites
                              child: Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(valoracion.userName ?? "Anónimo",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      RatingBarIndicator(
                                        rating: valoracion.valoracion ?? 0.0,
                                        itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        valoracion.comentario ??
                                            "Sin comentario",
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
