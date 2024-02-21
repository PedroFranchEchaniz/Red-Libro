package com.example.redlibro.user.controller;

import com.example.redlibro.security.jwt.access.JwtProvider;
import com.example.redlibro.security.jwt.refresh.RefreshTokenService;
import com.example.redlibro.user.dto.*;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;

    @PostMapping("/client/register")
    public ResponseEntity<ClienteResponse> createUserClient (@Valid @RequestBody CreateClientRequest createClientRequest){
        Client client = userService.createClient(createClientRequest);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ClienteResponse.fromUser(client));
    }

    @PostMapping("/client/login")
    public ResponseEntity<JwtClientResponse> login (@RequestBody LoginRequest loginRequest){
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginRequest.getUsername(),
                                loginRequest.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        Client client = (Client) authentication.getPrincipal();
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtClientResponse.of(client, token));
    }


    @GetMapping("/client/profile")
    public ResponseEntity<GetClienteDetoDetail> getLoggedClient(@AuthenticationPrincipal Client client){
        return ResponseEntity.ok(GetClienteDetoDetail.of(client));
    }
}
