package com.example.redlibro.booking.service;

import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.repository.BookingRepository;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.store.service.StoreService;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.repository.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class BookingService {

    private final StoreService storeservice;
    private final BookingRepository bookingRepository;
    private final StoreRepository storeRepository;
    private final ClientRepository clientRepository;
    public Booking reservar (StorePk storePk, UUID uuid){
        Store store = storeRepository.findById(storePk).get();
        storeservice.restarStore(storePk);

        Client client = clientRepository.findById(uuid).get();
        Booking booking = new Booking().builder()
                .shop(store.getShop())
                .client(client)
                .fechaReserva(LocalDate.now())
                .bookingCode(UUID.randomUUID())
                .book(store.getBook())
                .lat(store.getShop().getLat())
                .lon(store.getShop().getLon())
                .build();
        return bookingRepository.save(booking);
    }
}
