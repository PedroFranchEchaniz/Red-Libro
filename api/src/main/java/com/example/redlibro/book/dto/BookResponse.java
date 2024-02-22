package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;

@Builder
public record BookResponse(

        String isbn,
        String title,
        String editorial,
        String fechaAlta

) {
    public static BookResponse fromBook (Book book){


        return BookResponse.builder()
                .isbn(book.getISBN())
                .title(book.getTitulo())
                .editorial(book.getEditorial())
                .fechaAlta(book.getFechaAlta().toString())
                .build();
    }
}
