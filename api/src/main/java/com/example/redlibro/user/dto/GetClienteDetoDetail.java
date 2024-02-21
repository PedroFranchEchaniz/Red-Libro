package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Client;

public record GetClienteDetoDetail(
        String uuid,
        String name,
        String  lastName,
        String avatar,
        String username
) {
    public static GetClienteDetoDetail of (Client c){
        return new GetClienteDetoDetail(
                c.getUuid().toString(),
                c.getName(),
                c.getLastName(),
                c.getAvatar(),
                c.getUsername()
        );
    }
}
