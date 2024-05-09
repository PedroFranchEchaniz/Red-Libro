package com.example.redlibro.store.dto;

import com.example.redlibro.store.model.Store;
import lombok.Builder;

import java.util.UUID;

@Builder
public record AllStoreDto(
        String pk,
        String isbn,
        String titulo,
        int cantidad,
        UUID uuid

) {
    public static AllStoreDto fromStore(Store store){
        return AllStoreDto.builder()
                .pk(store.getStorePk().toString())
                .isbn(store.getStorePk().getBookIsbn())
                .titulo(store.getBook().getTitulo())
                .cantidad(store.getStock())
                .uuid(store.getShop().getUuid())
                .build();
    }
}
