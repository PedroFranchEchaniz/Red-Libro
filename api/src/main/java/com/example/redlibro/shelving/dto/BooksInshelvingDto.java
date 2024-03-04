package com.example.redlibro.shelving.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

@Builder
public record BooksInshelvingDto(
        String titulo,
        String portada,
        String autor,
        Double valoracionMedia
) {

    public static BooksInshelvingDto of (Book book){
        return BooksInshelvingDto.builder()
                .titulo(book.getTitulo())
                .portada(book.getPortada())
                .autor(book.getAutor())
                .valoracionMedia(book.getMediaValoracion())
                .build();
    }
}
