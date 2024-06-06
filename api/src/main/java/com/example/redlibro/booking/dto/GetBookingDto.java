package com.example.redlibro.booking.dto;

import com.example.redlibro.booking.model.Booking;
import lombok.Builder;

import java.time.LocalDate;
import java.util.UUID;

@Builder

public record GetBookingDto(
        UUID uuidShop,
        UUID uuid,
        UUID codigo,
        LocalDate fechaReserva,
        LocalDate fechaExpiacion,
        String nombreUsuario,
        String titulo,
        String portada,
        String idbn,
        String lat,
        String lon



) {

    public static GetBookingDto of (Booking booking){
        return GetBookingDto.builder()
                .uuidShop(booking.getShop().getUuid())
                .uuid(booking.getUuid())
                .codigo(booking.getBookingCode())
                .fechaReserva(booking.getFechaReserva())
                .fechaExpiacion(booking.getFechaExpiacion())
                .nombreUsuario(booking.getClient().getUsername())
                .idbn(booking.getBook().getISBN())
                .titulo(booking.getBook().getTitulo())
                .portada(booking.getBook().getPortada())
                .lat(booking.getLat())
                .lon(booking.getLon())
                .build();
    }
}
