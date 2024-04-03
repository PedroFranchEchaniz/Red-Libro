package com.example.redlibro.booking.service;

import com.example.redlibro.book.exception.ShopNotFoundException;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.booking.exceptions.ClientNotFoundException;
import com.example.redlibro.booking.model.Booking;
import com.example.redlibro.booking.repository.BookingRepository;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.store.service.StoreService;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.model.Shop;
import com.example.redlibro.user.repository.ClientRepository;
import com.example.redlibro.user.repository.ShopRepository;
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
    private final ShopRepository shopRepository;
    private final BookRepository bookRepository;
    public Booking reservar(StorePk storePk, UUID uuid) {
        Store store = storeRepository.findById(storePk)
                .orElseThrow(ShopNotFoundException::new);

        storeservice.restarStore(storePk);

        Client client = clientRepository.findById(uuid)
                .orElseThrow(ClientNotFoundException::new);

        Shop shop = shopRepository.findById(storePk.getShopUuid()).get();
        Book book = bookRepository.findById(storePk.getBookIsbn()).get();

        Booking booking = new Booking().builder()
                .shop(shop)
                .client(client)
                .fechaReserva(LocalDate.now())
                .bookingCode(UUID.randomUUID())
                .book(book)
                .lat(shop.getLat())
                .lon(shop.getLon())
                .fechaReserva(LocalDate.now())
                .fechaExpiacion(LocalDate.now().plusDays(3))
                .build();

        return bookingRepository.save(booking);
    }

}
