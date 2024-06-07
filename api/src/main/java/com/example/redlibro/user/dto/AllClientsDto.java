package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Client;
import lombok.Builder;

import java.util.UUID;

@Builder
public record AllClientsDto(
        UUID uuid,

        String username
) {
    public static AllClientsDto of (Client client){
        return AllClientsDto.builder()
                .uuid(client.getUuid())
                .username(client.getUsername())
                .build();
    }

}
