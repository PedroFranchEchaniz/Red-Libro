package com.example.redlibro.book.dto;

import com.example.redlibro.rating.dto.GetRatingDto;

import java.util.List;

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
        List<GetRatingDto> valoraciones
) {
}
