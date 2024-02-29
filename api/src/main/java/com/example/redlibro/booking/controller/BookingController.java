package com.example.redlibro.booking.controller;

import com.example.redlibro.book.service.BookService;
import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.service.BookingService;
import com.example.redlibro.store.model.StorePk;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class BookingController {

    private final BookingService bookingService;
    @PostMapping("/booking/{storePk}/{clientUUid}")
    public GetBookingDto reserva (@PathVariable StorePk pk, @PathVariable UUID uuid){
        return GetBookingDto.of(bookingService.reservar(pk, uuid));
    }
}
