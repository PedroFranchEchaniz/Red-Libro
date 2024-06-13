package com.example.redlibro.shelving.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

@Builder
public record BooksInshelvingDto(
        String isbn,
        String titulo,
        String portada,
        String autor,
        Double valoracionMedia
) {

    public static BooksInshelvingDto of (Book book){
        return BooksInshelvingDto.builder()
                .isbn(book.getISBN())
                .titulo(book.getTitulo())
                .portada(book.getPortada())
                .autor(book.getAutor())
                .valoracionMedia(book.getMediaValoracion())
                .build();
    }
}
