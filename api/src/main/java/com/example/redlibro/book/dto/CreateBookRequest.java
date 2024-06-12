package com.example.redlibro.book.dto;

import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.UUID;

public record CreateBookRequest(
        String ISBN,
        String titulo,
        String autor,
        String editorial,
        MultipartFile file,
        String fecha,
        String[]genres,
        String resumen,
        double mediaValoracion,
        int stock,
        LocalDate fechaRegistro
) {
}
