package com.example.redlibro.booking.repository;

import com.example.redlibro.booking.model.Booking;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface BookingRepository extends JpaRepository<Booking, UUID> {

    @Query("SELECT b from Booking b WHERE b.shop.uuid = ?1")
    Page<Booking> getShopBooking (UUID uuid, Pageable pageable);
}
