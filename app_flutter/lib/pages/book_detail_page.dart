import 'package:app_flutter/models/dto/rating_dto.dart';
import 'package:app_flutter/repositories/UserShevingRepository/user_shelving_repository_impl.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/shops_maps_page.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  final ShelvingRepositoryImpl shelvingRepository = ShelvingRepositoryImpl();
  final BookDetailRepository bookDetailRepository;

  BookDetailPage({
    Key? key,
    required this.book,
    required this.bookDetailRepository,
  }) : super(key: key);
  void _showRatingDialog(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    double _stars = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Valoración'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _stars = rating;
                  },
                ),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu comentario aquí',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enviar'),
              onPressed: () async {
                // Aquí se construye el RatingDto y se llama al método newRating
                final RatingDto ratingDto = RatingDto(
                  stars: _stars.toInt(),
                  opinion: _commentController.text,
                );
                try {
                  await bookDetailRepository.newRating(book.isbn!, ratingDto);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Valoración enviada con éxito.')));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al enviar la valoración.')));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        backgroundColor: Colors.blue,
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
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/image.png',
                      fit: BoxFit.cover);
                },
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(1)
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
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.portada ?? '',
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/image.png',
                              fit: BoxFit.cover);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    Text(book.titulo ?? "Sin título",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0))),
                    SizedBox(height: 10), // Espacio antes del autor
                    Text("Autor: ${book.autor ?? "Autor desconocido"}",
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 0, 0, 0))),
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
                        FutureBuilder<bool>(
                          future:
                              shelvingRepository.bookIsInShelving(book.isbn!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error');
                            } else if (snapshot.data == true) {
                              return Container();
                            } else {
                              return IconButton(
                                icon: Icon(Icons.bookmark_add,
                                    color: Colors.blue),
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
                                            content: Text(
                                                'Error al añadir el libro')));
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(book.resumen ?? "Resumen no disponible",
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(179, 0, 0, 0))),
                    ),
                    if (book.valoraciones == null ||
                        book.valoraciones!.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('No hay valoraciones disponibles',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(179, 0, 0, 0))),
                      )
                    ] else ...[
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: book.valoraciones?.length ?? 0,
                          itemBuilder: (context, index) {
                            final valoracion = book.valoraciones![index];
                            return Container(
                              width: 200,
                              child: Card(
                                color: Color.fromARGB(179, 255, 255, 255),
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
