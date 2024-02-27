package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

@Builder
public record GetBookWithRating(
        String isbn,
        String titulo,
        String autor,
        String editorial,
        String fecha,
        String fechaAlta,
        String portada,
        String genres,
        String resumen,
        Double valoracion,
        boolean disponible
) {
    public static GetBookWithRating of (Book book){
        return GetBookWithRating.builder()
                .isbn(book.getISBN())
                .titulo(book.getTitulo())
                .autor(book.getAutor())
                .editorial(book.getEditorial())
                .fecha(book.getFecha().toString())
                .fechaAlta(book.getFechaAlta().toString())
                .portada(book.getPortada())
                .genres(book.getGenres().toString())
                .resumen(book.getResumen())
                .valoracion(book.getMediaValoracion())
                .disponible(book.isDisponible())
                .build();
    }
}
