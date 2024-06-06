package com.example.redlibro.booking.controller;

import com.example.redlibro.book.service.BookService;
import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.service.BookingService;
import com.example.redlibro.store.model.StorePk;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class BookingController {

    private final BookingService bookingService;

    /*Corregir reserva, no esta bien pasar uuid como path variable*/
    @PostMapping("/booking/{shopUuid}/{bookisbn}/{clientUUid}")
    public GetBookingDto reserva (@PathVariable UUID shopUuid,
                                  @PathVariable String bookisbn,
                                  @PathVariable UUID clientUUid) {
        StorePk storePk = new StorePk();
        storePk.setBookIsbn(bookisbn);
        storePk.setShopUuid(shopUuid);
        return GetBookingDto.of(bookingService.reservar(storePk, clientUUid));
    }

    @GetMapping("/shopBooking/{shopUuid}")
    public ResponseEntity<Page<GetBookingDto>> getBookingShop (@PathVariable UUID shopUuid, @PageableDefault(page=0, size=4) Pageable pageable){
        Page<GetBookingDto> booking = bookingService.shopBooking(shopUuid, pageable).map(GetBookingDto::of);
        return ResponseEntity.ok(booking);
    }

    @DeleteMapping("/shopBooking/delete/{bookingUuid}")
    public void deleteBooking (@PathVariable UUID bookingUuid, @RequestParam String bookisbn, @RequestParam UUID shopUuid){
        StorePk storePk = new StorePk();
        storePk.setBookIsbn(bookisbn);
        storePk.setShopUuid(shopUuid);
        bookingService.deleteBooking(storePk, bookingUuid);
    }

}
