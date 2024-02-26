package com.example.redlibro.rating.model;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.user.model.Client;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
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
    @MapsId("bookIsbn")
    private Book book;

    private double stars;

    @ManyToOne
    @MapsId("clientId")
    private Client client;
}
