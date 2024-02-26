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
      body: Stack(
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
                    Colors.black.withOpacity(
                        0.3), // Más transparente en la parte superior
                    Colors.black.withOpacity(0.7), // Más opaco hacia la mitad
                    Colors.black,
                  ],
                  stops: [0.0, 0.3, 0.5],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(
                    0.5), // Color de fondo semi-transparente para el botón
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 5, // Ajuste de proporción para los detalles y la portada
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                          ],
                        ),
                      ),
                    ),
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
                            Text(
                              "Autor: ${book.autor ?? "Autor desconocido"}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Editorial: ${book.editorial ?? "Editorial desconocida"}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Aquí puedes repetir para más datos del libro...
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2, // Ajuste de proporción para el resumen
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      book.resumen ?? "Resumen no disponible",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              if (book.disponible!)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí va la lógica para realizar la reserva
                    },
                    child: Text('Reserva'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
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
