package com.example.redlibro.book.dto;

import java.time.LocalDate;

public record EditBookDto(

        String titulo,
        String autor,
        String editorial,
        String portda,
        String fecha,
        String[]genres,
        String resumen,
        String fechaEdicion,
        String uuid
) {
}
