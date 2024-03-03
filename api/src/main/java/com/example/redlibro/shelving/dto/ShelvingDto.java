package com.example.redlibro.shelving.dto;

import com.example.redlibro.shelving.Shelving;
import lombok.Builder;

import java.time.LocalDate;

@Builder
public record ShelvingDto(
        String isbn,
        String clientUuid,
        LocalDate fechaAlta,
        String titulo,
        String portada
) {
    public static ShelvingDto of (Shelving shelving){
        return ShelvingDto.builder()
                .isbn(shelving.getBook().getISBN())
                .clientUuid(shelving.getClient().getUuid().toString())
                .fechaAlta(shelving.getFechaAlta())
                .titulo(shelving.getBook().getTitulo())
                .portada(shelving.getBook().getPortada())
                .build();
    }
}
