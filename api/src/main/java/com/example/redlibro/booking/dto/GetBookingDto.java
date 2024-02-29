package com.example.redlibro.booking.dto;

import lombok.Builder;

import java.time.LocalDate;

@Builder

public record GetBookingDto(
        String codigo,
        LocalDate fechaReserva,
        String nombreUsuario,



) {
}
