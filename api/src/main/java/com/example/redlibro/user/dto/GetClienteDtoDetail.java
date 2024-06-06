package com.example.redlibro.user.dto;

import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.shelving.dto.BooksInshelvingDto;
import com.example.redlibro.user.model.Client;

import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

public record GetClienteDtoDetail(
        String uuid,
        String name,
        String lastName,
        String avatar,
        String username,
        Set<GetBookingDto> booking,
        Set<BooksInshelvingDto> shelving
) {
    public static GetClienteDtoDetail of (Client c){
        Set<GetBookingDto> bookingDtos = c.getBookings().stream()
                .map(booking -> new GetBookingDto(
                        booking.getShop().getUuid(),
                        booking.getUuid(),
                        booking.getBookingCode(),
                        booking.getFechaReserva(),
                        booking.getFechaExpiacion(),
                        booking.getClient().getUsername(),
                        booking.getBook().getTitulo(),
                        booking.getBook().getPortada(),
                        booking.getBook().getISBN(),
                        booking.getLat(),
                        booking.getLon()
                ))
                .collect(Collectors.toSet());


        Set<BooksInshelvingDto> shelvingDtos = c.getShelvings().stream()
                .map(shelving -> new BooksInshelvingDto(
                        shelving.getBook().getISBN(),                        shelving.getBook().getTitulo(),
                        shelving.getBook().getPortada(),
                        shelving.getBook().getMediaValoracion()
                ))
                .collect(Collectors.toSet());

        return new GetClienteDtoDetail(
                c.getUuid().toString(),
                c.getName(),
                c.getLastName(),
                c.getAvatar(),
                c.getUsername(),
                bookingDtos,
                shelvingDtos // Incluir los DTOs de shelvings aquí
        );
    }
}
