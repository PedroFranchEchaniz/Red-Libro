package com.example.redlibro.book.dto;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.rating.dto.GetRatingDto;
import com.example.redlibro.shelving.Shelving;
import com.example.redlibro.shelving.dto.ShelvingDto;
import lombok.Builder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Builder
public record GetBookAndRating(
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
        boolean disponible,
        LocalDateTime fechaEdicion,
        String nombreTienda,
        List<GetRatingDto> valoraciones
) {
    public static GetBookAndRating of(Book book) {
        return GetBookAndRating.builder()
                .isbn(book.getISBN())
                .titulo(book.getTitulo())
                .autor(book.getAutor())
                .editorial(book.getEditorial())
                .fecha(book.getFecha().toString())
                .fechaAlta(book.getFechaAlta().toString())
                .genres(book.getGenres().toString())
                .resumen(book.getResumen())
                .valoracion(book.getMediaValoracion())
                .disponible(book.isDisponible())
                .fechaEdicion(book.getFechaEdicion())
                .nombreTienda(book.getNombreTienda())
                .valoraciones(book.getRatings().stream()
                        .map(GetRatingDto::of)
                        .collect(Collectors.toList()))
                .build();


    }
}
