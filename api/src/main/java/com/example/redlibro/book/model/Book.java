package com.example.redlibro.book.model;

import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.store.Store;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.springframework.cglib.core.Local;
import org.w3c.dom.Text;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
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

    @Column(columnDefinition = "TEXT")
    private String resumen;

    @ElementCollection(fetch = FetchType.EAGER)
    private Set<Genre> genres;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Rating> ratings = new ArrayList<>();

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Store> stores = new ArrayList<>();
}