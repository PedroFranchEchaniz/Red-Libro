import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/book_detail_page.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository_impl.dart';

class BookListWidget extends StatelessWidget {
  final List<Book> books;
  final int categoryIndex;

  const BookListWidget({
    Key? key,
    required this.books,
    required this.categoryIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Verificar si la lista de libros está vacía
    if (books.isEmpty) {
      // Si está vacía, no se devuelve ningún widget (o se podría devolver un widget alternativo)
      return SizedBox.shrink(); // Esto devuelve un widget que no ocupa espacio.
    }

    // Si la lista no está vacía, se construye el widget normalmente
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Categoría ${categoryIndex + 1}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Container(
          height: 350,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<ShopBloc>(
                      create: (context) => ShopBloc(
                          shopWithBookRepository: ShopWithBookRepositoryImpl()),
                      child: BookDetailPage(book: book),
                    ),
                  ));
                },
                child: Container(
                  width: 180,
                  margin: EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: book.portada ?? '',
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[200],
                              alignment: Alignment.center,
                              child: Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book.titulo ?? "Sin título",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 235, 230, 230),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        book.autor ?? "Autor desconocido",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
