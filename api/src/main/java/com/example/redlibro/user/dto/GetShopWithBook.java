package com.example.redlibro.user.dto;

import com.example.redlibro.store.model.Store;
import com.example.redlibro.user.model.Shop;

public record GetShopWithBook(
        String name,
        String direccion,
        String lat,
        String lon,
        Double precio,

        String uuid

) {
    public static GetShopWithBook of (Store store){
        return new GetShopWithBook(
                store.getShop().getName(),
                store.getShop().getDireccion(),
                store.getShop().getLat(),
                store.getShop().getLon(),
                store.getPrecio(),
                store.getShop().getUuid().toString()
        );
    }
}
