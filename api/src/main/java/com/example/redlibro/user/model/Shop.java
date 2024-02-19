package com.example.redlibro.user.model;

import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Shop extends User{

    private String name;
    private String direccion;
    private String contacto;
    private String lat;
    private String lon;
}
