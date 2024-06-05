package com.example.redlibro.store.service;

import com.example.redlibro.book.exception.BookNotFoundException;
import com.example.redlibro.book.exception.ShopNotFoundException;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.store.dto.ChangeAmountStore;
import com.example.redlibro.store.dto.NewStoreRequest;
import com.example.redlibro.store.exception.ResourceNotFoundException;
import com.example.redlibro.store.exception.StorePkAllReadyExists;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.user.model.Shop;
import com.example.redlibro.user.repository.ShopRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class StoreService {

    private final StoreRepository storeRepository;
    private final ShopRepository shopRepository;
    private final BookRepository bookRepository;

    public Page<Store> findStoresByShopUuid(UUID uuid, Pageable pageable) {
        return storeRepository.findStoresByShopUuid(uuid, pageable);
    }

    public Store EditAmounStore(String isbn, ChangeAmountStore changeAmountStore){
        Store store = storeRepository.getStoreByIsbn(isbn, changeAmountStore.uuid())
                .orElseThrow(BookNotFoundException::new);
        store.setStock(changeAmountStore.cantidad());
        return storeRepository.save(store);
    }


    public void restarStore (StorePk pk){
        Store store = storeRepository.findById(pk)
                .orElseThrow(BookNotFoundException::new);
        store.setStock(store.getStock()-1);
        storeRepository.save(store);
    }

    public void sumarStore (StorePk pk){
        Store store = storeRepository.findById(pk)
                .orElseThrow(BookNotFoundException::new);
        store.setStock(store.getStock()+1);
        storeRepository.save(store);
    }

    public Store newBookInStore(NewStoreRequest newStoreRequest) {
        if (shopRepository.findById(UUID.fromString(newStoreRequest.shopUuid())).isEmpty()) {
            throw new ShopNotFoundException();
        }
        if (bookRepository.findById(newStoreRequest.bookIsbn()).isEmpty()) {
            throw new BookNotFoundException();
        }else{
            Book book = bookRepository.findById(newStoreRequest.bookIsbn()).get();
            Shop shop = shopRepository.findById(UUID.fromString(newStoreRequest.shopUuid())).get();
            StorePk storePk = new StorePk();
            storePk.setBookIsbn(newStoreRequest.bookIsbn());
            storePk.setShopUuid(UUID.fromString(newStoreRequest.shopUuid()));

            if (storeRepository.findById(storePk).isPresent()) {
                throw new StorePkAllReadyExists();
            }

            Store newStore = Store.builder()
                    .storePk(storePk)
                    .book(book)
                    .stock(newStoreRequest.cantidad())
                    .precio(newStoreRequest.precio())
                    .dateRegiste(LocalDate.now())
                    .shop(shop)
                    .build();

            return storeRepository.save(newStore);
        }
    }




}
