package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

@Builder
public record GetBookDto(
        String isbn,
        String titulo,
        String autor,
        String editorial,
        String fecha,
        String fechaAlta,
        String portada
) {
    public static GetBookDto of(Book book){
        return GetBookDto.builder()
                .isbn(book.getISBN())
                .titulo(book.getTitulo())
                .autor(book.getAutor())
                .editorial(book.getEditorial())
                .fecha(book.getFecha().toString())
                .fechaAlta(book.getFechaAlta().toString())
                .portada(book.getPortada())
                .build();
    }
}
