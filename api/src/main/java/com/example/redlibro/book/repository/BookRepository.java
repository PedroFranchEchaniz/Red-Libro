package com.example.redlibro.book.repository;

import com.example.redlibro.book.model.Book;
import org.hibernate.validator.constraints.ISBN;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface BookRepository extends JpaRepository<Book, String> {
}
