package com.example.redlibro.book.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
public class BookAlreadyExistsException extends RuntimeException{

    public BookAlreadyExistsException(){
        super("El libro ya esta dado de alta");
    }
}
