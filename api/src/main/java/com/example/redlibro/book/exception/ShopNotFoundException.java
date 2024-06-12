package com.example.redlibro.book.exception;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class ShopNotFoundException extends EntityNotFoundException {

    public ShopNotFoundException(){
        super("La tienda no ha sido encontrada");
    }
}
