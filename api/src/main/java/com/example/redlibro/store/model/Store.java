package com.example.redlibro.store.model;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.user.model.Shop;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Store {

    @EmbeddedId
    private StorePk storePk = new StorePk();
    private int stock;
    private LocalDate dateRegiste;
    private double precio;

    @ManyToOne
    @MapsId("shopUuid")
    @JoinColumn(name = "shop_uuid", referencedColumnName = "UUID")
    private Shop shop;

    @ManyToOne
    @MapsId("bookIsbn")
    @JoinColumn(name = "book_isbn", referencedColumnName = "ISBN")
    private Book book;

}
