package com.example.redlibro.store.dto;

import lombok.Builder;

import java.util.UUID;

@Builder
public record ChangeAmountStore(

        int cantidad,

        UUID uuid
) {

}
