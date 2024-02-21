package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Shop;
import lombok.Builder;

@Builder
public record ShopResponse(
        String id,
        String username,
        String name,
        String direccion,
        String contacto,
        String lat,
        String lon
) {
    public static ShopResponse fromShop(Shop shop){
        return ShopResponse.builder()
                .id(shop.getUuid().toString())
                .username(shop.getUsername())
                .name(shop.getName())
                .direccion(shop.getDireccion())
                .contacto(shop.getContacto())
                .lat(shop.getLat())
                .lon(shop.getLon())
                .build();
    }
}
