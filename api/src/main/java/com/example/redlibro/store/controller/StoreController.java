package com.example.redlibro.store.controller;

import com.example.redlibro.store.dto.AllStoreDto;
import com.example.redlibro.store.dto.ChangeAmountStore;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.store.service.StoreService;
import com.example.redlibro.user.dto.ClienteResponse;
import com.example.redlibro.user.dto.CreateClientRequest;
import com.example.redlibro.user.dto.GetShopDtoDetail;
import com.example.redlibro.user.model.Client;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ReactiveAdapterRegistry;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;

    @GetMapping("store/{shopUuid}/stores")
    public ResponseEntity<Page<AllStoreDto>> getStoresByShopUuid(@PathVariable UUID shopUuid, @PageableDefault(page=0, size=4) Pageable pageable) {
        Page<Store> stores = storeService.findStoresByShopUuid(shopUuid, pageable);
        Page<AllStoreDto> storeDtos = stores.map(AllStoreDto::fromStore);
        return ResponseEntity.ok(storeDtos);
    }

    @PutMapping("store/{isbn}")
    public AllStoreDto changeAmountStore(@PathVariable String isbn,@RequestBody ChangeAmountStore changeAmountStore){
        return AllStoreDto.fromStore(storeService.EditAmounStore(isbn, changeAmountStore));
    }


}
