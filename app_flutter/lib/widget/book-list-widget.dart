import 'package:app_flutter/pages/allBooks_page.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/book_detail_page.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository_impl.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (books.isEmpty) {
      return SizedBox.shrink();
    }

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
                      child: BookDetailPage(
                        book: book,
                        bookDetailRepository: BookDetailRepositoryImpl(),
                      ),
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
                          child: Image.network(
                            book.portada ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/image.png',
                                  fit: BoxFit.cover);
                            },
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
                          color: Color.fromARGB(255, 0, 0, 0),
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
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AllBooksPage(),
              ));
            },
            child: Text('Ver todos los libros'),
          ),
        ),
      ],
    );
  }
}
