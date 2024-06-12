package com.example.redlibro.booking.exceptions;

import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)

public class ClientNotFoundException extends EntityNotFoundException {

    public ClientNotFoundException(){
        super("Problema con el usuario, usuario no encotrado");
    }
}
