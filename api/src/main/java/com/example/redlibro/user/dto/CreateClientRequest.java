package com.example.redlibro.user.dto;


public record CreateClientRequest(
        String username,
        String password,
        String verifyPassword,
        String surname,
        String name
) {
}
