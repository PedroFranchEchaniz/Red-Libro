package com.example.redlibro.store.dto;

import lombok.Builder;

@Builder
public record NewStoreRequest(
        String shopUuid,
        String bookIsbn,
        int cantidad,
        double precio
) {
}
