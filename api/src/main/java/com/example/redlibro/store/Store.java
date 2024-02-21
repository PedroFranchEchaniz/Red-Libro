package com.example.redlibro.store;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.user.model.Shop;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Store {

    @EmbeddedId
    @Builder.Default
    private StorePk storePk= new StorePk();
    private int stock;

    @ManyToOne
    @JoinColumn(name = "shop_uuid")
    private Shop shop;

    @ManyToOne
    @JoinColumn(foreignKey = @ForeignKey(name = "book_isbn"))
    private Book book;

}
