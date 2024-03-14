package com.example.redlibro.book.exception;

public class BookAlreadyExistsException extends RuntimeException{

    public BookAlreadyExistsException(){
        super("El libro ya esta dado de alta");
    }
}
