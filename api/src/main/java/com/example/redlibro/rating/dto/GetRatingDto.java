package com.example.redlibro.rating.dto;

public record GetRatingDto(
        String userName,
        Double valoracion,
        String comentario
) {
}
