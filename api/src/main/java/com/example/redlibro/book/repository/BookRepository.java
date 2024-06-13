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

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 0")
    List<Book> findByFantasyBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 1")
    List<Book> findByDetectiveBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 2")
    List<Book> findByAdventureBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 3")
    List<Book> findByMysteryBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 4")
    List<Book> findByScienceFictionBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 5")
    List<Book> findByFictionBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 6")
    List<Book> findByNonFictionBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 7")
    List<Book> findByDramaBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 8")
    List<Book> findByRomanceBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 9")
    List<Book> findByThrillerBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 10")
    List<Book> findByHorrorBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 11")
    List<Book> findByBiographyBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 12")
    List<Book> findByAutobiographyBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 13")
    List<Book> findByPoetryBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 14")
    List<Book> findByEssayBooks();

    @Query("SELECT b FROM Book b JOIN b.genres g WHERE g = 15")
    List<Book> findByHistoryBooks();

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
