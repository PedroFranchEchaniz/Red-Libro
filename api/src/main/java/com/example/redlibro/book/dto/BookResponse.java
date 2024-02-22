package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

@Builder
public record BookResponse(

        String isbn,
        String title,
        String editorial
) {
    public static BookResponse fromBook (Book book){
        return BookResponse.builder()
                .isbn(book.getISBN())
                .title(book.getTitulo())
                .editorial(book.getEditorial())
                .build();
    }
}
