package com.example.redlibro.book.exception;

import jakarta.persistence.EntityNotFoundException;

public class ShopNotFoundException extends EntityNotFoundException {

    public ShopNotFoundException(){
        super("La tienda no ha sido encontrada");
    }
}
