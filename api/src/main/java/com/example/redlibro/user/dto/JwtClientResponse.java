package com.example.redlibro.user.dto;

import com.example.redlibro.user.model.Client;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JwtClientResponse extends ClienteResponse {

    private String token;
    private String refreshToken;

    public JwtClientResponse(ClienteResponse clienteResponse) {
        id = clienteResponse.getId();
        username = clienteResponse.getUsername();
        name = clienteResponse.getName();
        roles=clienteResponse.getRoles();
        lastName= clienteResponse.getLastName();
    }

    public static JwtClientResponse of (Client client, String token) {
        JwtClientResponse result = new JwtClientResponse(ClienteResponse.fromUser(client));
        result.setToken(token);
        return result;

    }

}