package com.example.redlibro.user.dto;

public record CreateShopRequest(

        String username,
        String password,
        String verifyPassword,
        String name,
        String direcction,
        String contacto,
        String lat,
        String lon
) {
}
