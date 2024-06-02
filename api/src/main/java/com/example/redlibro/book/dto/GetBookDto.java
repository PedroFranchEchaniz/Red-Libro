package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import lombok.Builder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import com.example.redlibro.book.model.Genre;


@Builder
public record GetBookDto(
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
        LocalDateTime fechaEdicion,
        String nombreTienda
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
                .genres(book.getGenres().stream().map(Genre::name).toArray(String[]::new))
                .resumen(book.getResumen())
                .fechaEdicion(book.getFechaEdicion())
                .nombreTienda(book.getNombreTienda())
                .build();
    }
}
