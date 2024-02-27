package com.example.redlibro.shelving;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.user.model.Client;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Shelving {

    @EmbeddedId
    private ShelvingPk shelvingPk = new ShelvingPk();

    @ManyToOne
    @JoinColumn(name = "client_uuid", referencedColumnName = "UUID")
    private Client client;


    @ManyToOne
    @MapsId("book_isbn")
    @JoinColumn(name = "book_isbn", referencedColumnName = "ISBN")
    private Book book;

    LocalDate fechaAlta;

}
