package com.example.redlibro.book.exception;

import jakarta.persistence.EntityNotFoundException;

public class BookNotFoundException extends EntityNotFoundException {

    public BookNotFoundException(){
        super("Libro no encontrado");
    }
}
