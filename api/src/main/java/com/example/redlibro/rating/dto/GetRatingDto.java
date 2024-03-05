package com.example.redlibro.rating.dto;

import com.example.redlibro.rating.model.Rating;
import lombok.Builder;

@Builder
public record GetRatingDto(
        String userName,
        Double valoracion,
        String comentario
) {
    public static GetRatingDto of (Rating rating){
        return GetRatingDto.builder()
                .userName(rating.getClient().getUsername())
                .valoracion(rating.getStars())
                .comentario(rating.getOpinion())
                .build();
    }
}
