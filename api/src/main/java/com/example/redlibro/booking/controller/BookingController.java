package com.example.redlibro.booking.controller;

import com.example.redlibro.book.dto.GetBookDto;
import com.example.redlibro.book.service.BookService;
import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.service.BookingService;
import com.example.redlibro.store.model.StorePk;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Reservar un libro", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                   "uuidShop": "123e4567-e89b-12d3-a456-426614174000",
                                                   "uuid": "123e4567-e89b-12d3-a456-426614174001",
                                                   "codigo": "123e4567-e89b-12d3-a456-426614174002",
                                                   "fechaReserva": "2024-06-12",
                                                   "fechaExpiacion": "2024-06-19",
                                                   "nombreUsuario": "Juan Perez",
                                                   "titulo": "El libro de ejemplo",
                                                   "portada": "https://example.com/portada.jpg",
                                                   "idbn": "9876543210",
                                                   "lat": "40.712776",
                                                   "lon": "-74.005974"
                                                 }
                                                
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500", description = "Internal server error"),
            @ApiResponse(responseCode = "404", description = "Tienda no encontrada", content = @Content),
            @ApiResponse(responseCode = "404", description = "Cliente no encontrado", content = @Content)

    })
    @PostMapping("/booking/{shopUuid}/{bookisbn}/{clientUUid}")
    public GetBookingDto reserva (@PathVariable UUID shopUuid,
                                  @PathVariable String bookisbn,
                                  @PathVariable UUID clientUUid) {
        StorePk storePk = new StorePk();
        storePk.setBookIsbn(bookisbn);
        storePk.setShopUuid(shopUuid);
        return GetBookingDto.of(bookingService.reservar(storePk, clientUUid));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtener las reservas de una tienda", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                    "content": [
                                                      {
                                                        "uuidShop": "123e4567-e89b-12d3-a456-426614174000",
                                                        "uuid": "123e4567-e89b-12d3-a456-426614174001",
                                                        "codigo": "123e4567-e89b-12d3-a456-426614174002",
                                                        "fechaReserva": "2024-06-12",
                                                        "fechaExpiacion": "2024-06-19",
                                                        "nombreUsuario": "Juan Perez",
                                                        "titulo": "El libro de ejemplo",
                                                        "portada": "https://example.com/portada.jpg",
                                                        "idbn": "9876543210",
                                                        "lat": "40.712776",
                                                        "lon": "-74.005974"
                                                      },
                                                      {
                                                        "uuidShop": "123e4567-e89b-12d3-a456-426614174003",
                                                        "uuid": "123e4567-e89b-12d3-a456-426614174004",
                                                        "codigo": "123e4567-e89b-12d3-a456-426614174005",
                                                        "fechaReserva": "2024-07-12",
                                                        "fechaExpiacion": "2024-07-19",
                                                        "nombreUsuario": "Maria Lopez",
                                                        "titulo": "Otro libro de ejemplo",
                                                        "portada": "https://example.com/otra-portada.jpg",
                                                        "idbn": "0987654321",
                                                        "lat": "34.052235",
                                                        "lon": "-118.243683"
                                                      }
                                                    ],
                                                    "pageable": {
                                                      "sort": {
                                                        "sorted": true,
                                                        "unsorted": false,
                                                        "empty": false
                                                      },
                                                      "pageNumber": 0,
                                                      "pageSize": 20,
                                                      "offset": 0,
                                                      "paged": true,
                                                      "unpaged": false
                                                    },
                                                    "totalElements": 2,
                                                    "totalPages": 1,
                                                    "last": true,
                                                    "first": true,
                                                    "numberOfElements": 2,
                                                    "size": 20,
                                                    "number": 0,
                                                    "sort": {
                                                      "sorted": true,
                                                      "unsorted": false,
                                                      "empty": false
                                                    },
                                                    "empty": false
                                               }
                                                
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Fallo al generar la reserva", content = @Content)
    })
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
