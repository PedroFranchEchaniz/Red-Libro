package com.example.redlibro.store.exception;

public class ResourceNotFoundException extends RuntimeException{
    public ResourceNotFoundException() {
        super("No se puede encontrar el store");
    }

}
