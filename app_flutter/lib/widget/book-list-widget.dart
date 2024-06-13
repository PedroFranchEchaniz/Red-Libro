import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:app_flutter/pages/allBooks_page.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter/models/response/book_response.dart';
import 'package:app_flutter/pages/book_detail_page.dart';
import 'package:app_flutter/repositories/bookDetail/bookDetail_repository_impl.dart';
import 'package:app_flutter/blocs/shopBook-bloc/bloc/shop_bloc.dart';
import 'package:app_flutter/repositories/shopWithBook/shopWithBook_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookListWidget extends StatelessWidget {
  final List<Book> books;
  final int categoryIndex;
  final String genre; // Nuevo parámetro para el género
  final String baseUrl = 'http://10.0.2.2:8080/portadas/';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  BookListWidget({
    Key? key,
    required this.books,
    required this.categoryIndex,
    required this.genre, // Agregamos el género
  }) : super(key: key);

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: 'authToken');
    return {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<ImageProvider> _loadImage(String imageUrl) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(imageUrl), headers: headers);
    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

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
            genre, // Mostramos el género en lugar de 'Categoría ${categoryIndex + 1}'
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
              final imageUrl = baseUrl + (book.portada ?? '');

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
                          child: FutureBuilder<ImageProvider>(
                            future: _loadImage(imageUrl),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Image.asset('assets/images/image.png',
                                      fit: BoxFit.cover);
                                } else {
                                  return Image(
                                    image: snapshot.data!,
                                    fit: BoxFit.cover,
                                  );
                                }
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
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
