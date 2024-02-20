package com.example.redlibro.user.exception;

public class PasswordNotValidException extends RuntimeException{
    public PasswordNotValidException(){
        super("Las contraseñas no coincide");
    }
}
