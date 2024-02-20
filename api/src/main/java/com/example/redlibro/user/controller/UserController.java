package com.example.redlibro.user.controller;

import com.example.redlibro.security.jwt.access.JwtProvider;
import com.example.redlibro.security.jwt.refresh.RefreshTokenService;
import com.example.redlibro.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;

    @PostMapping("/shop/register")
    public ResponseEntity<ClientRes>
}
