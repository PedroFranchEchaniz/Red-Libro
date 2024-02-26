import 'package:app_flutter/models/response/book_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.titulo ?? 'Sin título'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fondo con la imagen de portada y el degradado
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
                    Colors.black.withOpacity(0.0),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          // Contenido dividido en dos columnas
          Row(
            children: [
              // Columna para la portada del libro
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Centra el contenido verticalmente
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.portada ?? '',
                          width: MediaQuery.of(context).size.width *
                              0.4, // Ajusta el ancho según necesites
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: 8), // Espacio entre la imagen y la valoración
                      RatingBarIndicator(
                        rating: book.valoracion ??
                            0.0, // Asegúrate de que `book.valoracion` no sea nulo
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5, // Número total de estrellas
                        itemSize: 24.0, // Tamaño de las estrellas
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ),
              ),
              // Columna para los datos del libro
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.titulo ?? "Sin título",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text("Autor: ${book.autor ?? "Autor desconocido"}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                      Text(
                          "Editorial: ${book.editorial ?? "Editorial desconocida"}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 8),
                      // Repite para los demás datos del libro...
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
