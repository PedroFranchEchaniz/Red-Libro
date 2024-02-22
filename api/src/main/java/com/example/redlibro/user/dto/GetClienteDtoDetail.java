package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Client;

public record GetClienteDtoDetail(
        String uuid,
        String name,
        String lastName,
        String avatar,
        String username
) {
    public static GetClienteDtoDetail of (Client c){
        return new GetClienteDtoDetail(
                c.getUuid().toString(),
                c.getName(),
                c.getLastName(),
                c.getAvatar(),
                c.getUsername()
        );
    }
}
