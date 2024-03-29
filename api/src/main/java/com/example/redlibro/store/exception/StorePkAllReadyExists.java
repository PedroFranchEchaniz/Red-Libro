package com.example.redlibro.store.exception;

public class StorePkAllReadyExists extends RuntimeException{

    public StorePkAllReadyExists() {
        super("El libro ya esta registrado en tu almacen");
    }
}
