package com.example.redlibro.book.repository;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import org.hibernate.validator.constraints.ISBN;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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

    @Query("SELECT b FROM Book b LEFT JOIN FETCH b.ratings WHERE b.ISBN = :isbn")
    Optional<Book> findByIdWithRatings(String isbn);

    @Query("SELECT b FROM Book b JOIN b.genres g " +
            "WHERE (:titulo IS NULL OR b.titulo LIKE %:titulo%) " +
            "AND (:autor IS NULL OR b.autor LIKE %:autor%) " +
            "AND (:editorial IS NULL OR b.editorial LIKE %:editorial%) " +
            "AND (:disponible IS NULL OR b.disponible = :disponible) " +
            "AND (:genre IS NULL OR g = :genre)")
    List<Book> filterBooks(@Param("titulo") String titulo,
                           @Param("autor") String autor,
                           @Param("editorial") String editorial,
                           @Param("disponible") Boolean disponible,
                           @Param("genre") Genre genre);

    boolean existsByISBN(String isbn);

}
