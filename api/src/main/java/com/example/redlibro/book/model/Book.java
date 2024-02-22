package com.example.redlibro.book.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;
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
    private LocalDate fecha;
    private LocalDate fechaAlta;

    @ElementCollection(fetch = FetchType.EAGER)
    private Set<Genre> genres;

}
