package com.example.redlibro.booking.dto;

import com.example.redlibro.booking.model.Booking;
import lombok.Builder;

import java.time.LocalDate;

@Builder

public record GetBookingDto(
        String codigo,
        LocalDate fechaReserva,
        String nombreUsuario,

        String titulo,
        String idbn



) {

    public static GetBookingDto of (Booking booking){
        return GetBookingDto.builder()
                .codigo(booking.getBookingCode().toString())
                .fechaReserva(booking.getFechaReserva())
                .nombreUsuario(booking.getClient().getUsername())
                .idbn(booking.getBook().getISBN())
                .titulo(booking.getBook().getTitulo())
                .build();
    }
}
