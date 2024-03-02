package com.example.redlibro.store.service;

import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class StoreService {

    private final StoreRepository storeRepository;
    public void restarStore (StorePk pk){
        Store store = storeRepository.findById(pk).get();
        store.setStock(store.getStock()-1);
    }
}
