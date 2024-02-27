package com.example.redlibro.rating.repository;

import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.rating.model.RatingPk;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface RatingRepository extends JpaRepository<Rating, RatingPk> {

    @Query("SELECT AVG(r.stars) FROM Rating r WHERE r.book.ISBN = ?1")
    Optional<Double>bookAvgRating(String isbn);

    @Query("SELECT r.book.ISBN, AVG(r.stars) FROM Rating r WHERE r.book.ISBN IN :isbns GROUP BY r.book.ISBN")
    List<Object[]> findAvgRatingsForBooks(@Param("isbns") List<String> isbns);
}
