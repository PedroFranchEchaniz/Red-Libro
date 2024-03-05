package com.example.redlibro.shelving.Repository;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.shelving.Shelving;
import com.example.redlibro.shelving.ShelvingPk;
import com.example.redlibro.shelving.dto.BooksInshelvingDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ShelvingRepository extends JpaRepository<Shelving, ShelvingPk> {

    @Query("SELECT COUNT(s) FROM Shelving s WHERE s.book.ISBN = ?1")
    int isbnIsPresent(String isbn);

    @Query("SELECT new com.example.redlibro.shelving.dto.BooksInshelvingDto(s.book.titulo, s.book.portada, s.book.autor, s.book.mediaValoracion) FROM Shelving s WHERE s.client.uuid = ?1")
    List<BooksInshelvingDto> shelvingOfClient(UUID id);

}
