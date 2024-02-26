package com.example.redlibro.book.service;

import com.example.redlibro.book.dto.CreateBookRequest;
import com.example.redlibro.book.dto.GetBookDto;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.rating.repository.RatingRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Array;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookService {

    private final BookRepository bookRepository;
    private final RatingRepository ratingRepository;

    public Book createBook(CreateBookRequest createBookRequest) {

        if (bookRepository.findById(createBookRequest.ISBN()).isPresent())
            return null;
        Set<Genre> genres = Arrays.stream(createBookRequest.genres())
                .map(Genre::valueOf)
                .collect(Collectors.toSet());
        LocalDate fecha = LocalDate.parse(createBookRequest.fecha());

        Book b = Book.builder()
                .ISBN(createBookRequest.ISBN())
                .titulo(createBookRequest.titulo())
                .autor(createBookRequest.autor())
                .editorial(createBookRequest.editorial())
                .portada(createBookRequest.portda())
                .genres(genres)
                .fecha(fecha)
                .fechaAlta(LocalDate.now())
                .mediaValoracion(0.0)
                .build();
       return bookRepository.save(b);
    }

   public List<Book>[] librosOrdenados (){
        List<Book>[] arrayBooks = (List<Book>[])new List<?>[5];

        arrayBooks[0] = bookRepository.fantasybooks();
        arrayBooks[1] = bookRepository.detectivebooks();
        arrayBooks[4] = bookRepository.syfybooks();

       for (int i = 0; i < arrayBooks.length; i++) {
           if (arrayBooks[i] == null) {
               arrayBooks[i] = new ArrayList<>();
           }
       }
       List<String> allIsbns = Arrays.stream(arrayBooks)
               .filter(Objects::nonNull)
               .flatMap(List::stream)
               .map(Book::getISBN)
               .collect(Collectors.toList());

       // Obtiene las valoraciones medias para esos ISBNs
       List<Object[]> avgRatings = ratingRepository.findAvgRatingsForBooks(allIsbns);
       Map<String, Double> isbnToAvgRating = avgRatings.stream()
               .collect(Collectors.toMap(
                       avgRating -> (String) avgRating[0], // ISBN
                       avgRating -> (Double) avgRating[1]  // Valoración media
               ));

       // Asigna las valoraciones medias a los libros
       Arrays.stream(arrayBooks)
               .filter(Objects::nonNull)
               .flatMap(List::stream)
               .forEach(book -> book.setMediaValoracion(isbnToAvgRating.getOrDefault(book.getISBN(), 0.0)));

       return arrayBooks;
    }

    public Book libroMedia(String isbn) {
        Optional<Book> b = bookRepository.findById(isbn);
        if (b.isPresent()) {
            Book bookEncontrado = b.get();
            Optional<Double> avgRating = ratingRepository.bookAvgRating(isbn);
            if (avgRating.isPresent()) {
                double average = avgRating.get();
                bookEncontrado.setMediaValoracion(average);
            } else {
                bookEncontrado.setMediaValoracion(0.0);
            }
            return bookEncontrado;
        } else {
            return null;
        }
    }
}
