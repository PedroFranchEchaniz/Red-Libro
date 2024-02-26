package com.example.redlibro.book.service;

import com.example.redlibro.book.dto.CreateBookRequest;
import com.example.redlibro.book.dto.GetBookDto;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import com.example.redlibro.book.repository.BookRepository;
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
        return arrayBooks;
    }

    /*public GetBookDto getBookWtihAverageRating (String isbn){
        Book book = bookRepository.findById(isbn).orElseThrow(() -> new IllegalArgumentException("Libro no encontrado"));
        Optional<Double> averageRating = bookRepository.getAverageRatingByIsb(isbn);
        double mediaValoraciones = averageRating.orElse(0.0);
        return GetBookDto.of(book, mediaValoraciones);
    }*/
}
