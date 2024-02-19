package com.example.redlibro.security.errorhandling;

public class JwtTokenException extends RuntimeException{

    public JwtTokenException(String msq){
        super(msq);
    }
}
