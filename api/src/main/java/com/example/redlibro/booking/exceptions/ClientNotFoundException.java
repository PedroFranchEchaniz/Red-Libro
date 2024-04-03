package com.example.redlibro.booking.exceptions;

import jakarta.persistence.EntityNotFoundException;

public class ClientNotFoundException extends EntityNotFoundException {

    public ClientNotFoundException(){
        super("Problema con el usuario, usuario no encotrado");
    }
}
