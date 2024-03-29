package com.example.redlibro.store.dto;

import com.example.redlibro.store.model.Store;
import lombok.Builder;

@Builder
public record AllStoreDto(
        String pk,
        String isbn,
        String titulo,
        int cantidad

) {
    public static AllStoreDto fromStore(Store store){
        return AllStoreDto.builder()
                .pk(store.getStorePk().toString())
                .isbn(store.getStorePk().getBookIsbn())
                .isbn(store.getBook().getTitulo())
                .cantidad(store.getStock())
                .build();
    }
}
