package com.example.redlibro.user.repository;

import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.user.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ClientRepository extends JpaRepository<Client, UUID> {

    Optional<Client> findFirstByUsername(String username);

    @Query("SELECT new com.example.redlibro.booking.dto.GetBookingDto(b.bookingCode, b.fechaReserva, b.fechaExpiacion, b.client.username, b.book.titulo, b.book.portada, b.book.ISBN, b.lat, b.lon) FROM Booking b WHERE b.client.uuid = :clientUuid")
    List<GetBookingDto> findBookingsByClientUuid(UUID clientUuid);

    @Query("SELECT c FROM Client c LEFT JOIN FETCH c.bookings WHERE c.uuid = :uuid")
    Optional<Client> findClientWithBookings(UUID uuid);

    @Query("SELECT c FROM Client c LEFT JOIN FETCH c.ratings WHERE c.uuid = :uuid")
    Optional<Client> findClientWithRatings(UUID uuid);
}



