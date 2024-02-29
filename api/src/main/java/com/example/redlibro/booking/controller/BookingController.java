package com.example.redlibro.booking.controller;

import com.example.redlibro.book.service.BookService;
import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.service.BookingService;
import com.example.redlibro.store.model.StorePk;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class BookingController {

    private final BookingService bookingService;
    @PostMapping("/booking/{shopUuid}/{bookisbn}/{clientUUid}")
    public GetBookingDto reserva (@PathVariable UUID shopUuid,
                                  @PathVariable String bookisbn,
                                  @PathVariable UUID clientUUid) {
        StorePk storePk = new StorePk();
        storePk.setBookIsbn(bookisbn);
        storePk.setShopUuid(shopUuid);
        return GetBookingDto.of(bookingService.reservar(storePk, clientUUid));
    }

}
