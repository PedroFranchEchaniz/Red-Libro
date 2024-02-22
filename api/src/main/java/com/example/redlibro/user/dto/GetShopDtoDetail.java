package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Shop;

public record GetShopDtoDetail(
        String uuid,
        String name,
        String direccion,
        String contacto,
        String lat,
        String lon
) {
    public static GetShopDtoDetail of (Shop s){
        return new GetShopDtoDetail(
                s.getUuid().toString(),
                s.getName(),
                s.getDireccion(),
                s.getContacto(),
                s.getLat(),
                s.getLon()
        );
    }
}
