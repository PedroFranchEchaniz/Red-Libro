package com.example.redlibro.store.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;
@ResponseStatus(HttpStatus.NOT_FOUND)

public class StoreNotFoundException extends RuntimeException{
    public StoreNotFoundException() {
        super("Store not found");
    }
}
