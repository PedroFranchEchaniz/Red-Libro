package com.example.redlibro.store.service;

import com.example.redlibro.book.exception.BookNotFoundException;
import com.example.redlibro.book.exception.ShopNotFoundException;
import com.example.redlibro.book.model.Book;
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

    public Page<Store> findStoresByShopUuid(UUID uuid, Pageable pageable) {
        return storeRepository.findStoresByShopUuid(uuid, pageable);
    }

    public void sumarStore(StorePk pk, int cantidad){
        Store store = storeRepository.findById(pk)
                .orElseThrow(BookNotFoundException::new);
        store.setStock(store.getStock()+cantidad);
        storeRepository.save(store);
    }


    public void restarStore (StorePk pk){
        Store store = storeRepository.findById(pk)
                .orElseThrow(BookNotFoundException::new);
        store.setStock(store.getStock()-1);
        storeRepository.save(store);
    }

    public void newBookInStore(String isbn, UUID uuidShop, int cantidad) {

        if(shopRepository.findById(uuidShop).isEmpty()){
            throw new ShopNotFoundException();
        }else{
            Shop shop = shopRepository.findById(uuidShop).get();
            StorePk storePk = new StorePk();
            if(storeRepository.findById(storePk).isPresent()){
                throw new StorePkAllReadyExists();
            }
            storePk.setBookIsbn(isbn);
            storePk.setShopUuid(uuidShop);
            Store newStore = Store.builder()
                    .storePk(storePk)
                    .stock(cantidad)
                    .dateRegiste(LocalDate.now())
                    .build();
            storeRepository.save(newStore);
        }

    }




}
