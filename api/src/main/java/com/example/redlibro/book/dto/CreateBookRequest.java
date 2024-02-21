package com.example.redlibro.book.dto;

public record CreateBookRequest(
        String ISBN,
        String titulo,
        String autor,
        String editorial,
        String portda,
        String[]genres

) {
}
