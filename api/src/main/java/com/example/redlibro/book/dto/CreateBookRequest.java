package com.example.redlibro.book.dto;

import java.time.LocalDate;
import java.util.UUID;

public record CreateBookRequest(
        String ISBN,
        String titulo,
        String autor,
        String editorial,
        String portda,
        String fecha,
        String[]genres,
        String resumen,
        double mediaValoracion,
        String uuidShor,
        int stock,
        LocalDate fechaRegistro

) {
}
