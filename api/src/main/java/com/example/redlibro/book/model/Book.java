package com.example.redlibro.book.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

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
    private double precio;

    @ManyToOne
    @JoinColumn(name = "genre_uuid")
    private Genre genre;

}
