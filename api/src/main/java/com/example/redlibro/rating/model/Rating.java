package com.example.redlibro.rating.model;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.user.model.Client;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Rating implements Serializable {
    @EmbeddedId
    private RatingPk id = new RatingPk();

    @ManyToOne
    @JsonIgnore
    @MapsId("bookIsbn")
    private Book book;

    private double stars;
    @ManyToOne
    @JsonIgnore
    @MapsId("clientId")
    private Client client;

    @Column(columnDefinition = "TEXT")
    private String opinion;
}
