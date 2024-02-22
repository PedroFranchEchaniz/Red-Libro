import 'package:app_flutter/models/response/book_response.dart';

class ArrayBooksResponse {
  List<List<Book>> books;

  ArrayBooksResponse({required this.books});

  factory ArrayBooksResponse.fromJson(List<dynamic> parsedJson) {
    List<List<Book>> books = [];
    for (var i = 0; i < parsedJson.length; i++) {
      List<Book> bookList = [];
      for (var j = 0; j < parsedJson[i].length; j++) {
        bookList.add(Book.fromJson(parsedJson[i][j]));
      }
      books.add(bookList);
    }
    return ArrayBooksResponse(books: books);
  }

  List<dynamic> toJson() {
    List<dynamic> booksJson = [];
    for (List<Book> bookList in books) {
      List<dynamic> bookListJson = [];
      for (Book book in bookList) {
        bookListJson.add(book.toJson());
      }
      booksJson.add(bookListJson);
    }
    return booksJson;
  }
}
