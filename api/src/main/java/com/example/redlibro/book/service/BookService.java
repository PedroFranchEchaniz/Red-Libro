package com.example.redlibro.book.service;

import com.example.redlibro.book.dto.CreateBookRequest;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import com.example.redlibro.book.repository.BookRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Set;
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
}
