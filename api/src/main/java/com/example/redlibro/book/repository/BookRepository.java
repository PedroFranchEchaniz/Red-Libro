package com.example.redlibro.book.repository;

import com.example.redlibro.book.model.Book;
import org.hibernate.validator.constraints.ISBN;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BookRepository extends JpaRepository<Book, String> {

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 0")
    List<Book> fantasybooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 1")
    List<Book> detectivebooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 4")
    List<Book> syfybooks();
}
