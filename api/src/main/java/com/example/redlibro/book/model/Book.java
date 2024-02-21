package com.example.redlibro.book.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Book {

    @Id
    private String ISBN;
    private String titulo;
    private String autor;
    private String editorial;
    private String portada;

    @ElementCollection(fetch = FetchType.EAGER)
    private Set<Genre> genres;

}
