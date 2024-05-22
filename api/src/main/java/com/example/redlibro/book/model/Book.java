package com.example.redlibro.book.model;

import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.store.model.Store;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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
    private double mediaValoracion;
    private boolean disponible;

    @Column(columnDefinition = "TEXT")
    private String resumen;

    @ElementCollection(fetch = FetchType.EAGER)
    private Set<Genre> genres;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true) //revisar cascadeType.All soft Delete
    private List<Rating> ratings = new ArrayList<>();

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Store> stores = new ArrayList<>();
}