package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Shop;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.Set;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ShopResponse {

    protected String id, username, name, direccion, contacto, lat, lon;
    protected Set<String> roles;
    public static ShopResponse fromShop(Shop shop){
        return ShopResponse.builder()
                .id(shop.getUuid().toString())
                .username(shop.getUsername())
                .name(shop.getName())
                .direccion(shop.getDireccion())
                .contacto(shop.getContacto())
                .lat(shop.getLat())
                .lon(shop.getLon())
                .roles(shop.getRoles().stream()
                        .map(Enum::name)
                        .collect(Collectors.toSet()))
                .build();
    }
}
