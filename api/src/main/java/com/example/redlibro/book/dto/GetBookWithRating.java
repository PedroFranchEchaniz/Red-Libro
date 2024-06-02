package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record GetBookWithRating(
        String isbn,
        String titulo,
        String autor,
        String editorial,
        String fecha,
        String fechaAlta,
        String portada,
        String[] genres,
        String resumen,
        Double valoracion,
        boolean disponible,
        LocalDateTime fechaEdicion,
        String nombreTienda
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
                .genres(book.getGenres().stream().map(Genre::name).toArray(String[]::new))
                .resumen(book.getResumen())
                .valoracion(book.getMediaValoracion())
                .disponible(book.isDisponible())
                .fechaEdicion(book.getFechaEdicion())
                .nombreTienda(book.getNombreTienda())
                .build();
    }
}
