package com.example.redlibro.security.errorhandling;

public class TokenRefreshException extends RuntimeException {
    public TokenRefreshException(String token, String message){
        super(String.format("Failed for [%s]: %s", token, message));
    }
}
