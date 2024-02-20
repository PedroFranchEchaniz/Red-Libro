package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Client;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.Set;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClienteResponse {

    protected String id;
    protected String username, name, lastName;
    protected Set<String> roles;




    public static ClienteResponse fromUser(Client client) {

        return ClienteResponse.builder()
                .id(client.getUuid().toString())
                .username(client.getUsername())
                .name(client.getName())
                .lastName(client.getLastName())
                .roles(client.getRoles().stream()
                        .map(Enum::name)
                        .collect(Collectors.toSet()))
                .build();
    }

}
