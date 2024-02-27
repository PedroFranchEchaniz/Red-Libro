package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Shop;

public record GetShopWithBook(
        String name,
        String direccion,

        String lat,

        String lon
) {
    public static GetShopWithBook of (Shop p){
        return new GetShopWithBook(
                p.getName(),
                p.getDireccion(),
                p.getLat(),
                p.getLon()
        );
    }
}
