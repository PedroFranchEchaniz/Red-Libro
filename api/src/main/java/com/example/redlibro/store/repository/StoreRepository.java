package com.example.redlibro.store.repository;

import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.user.model.Shop;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StoreRepository extends JpaRepository<Store, StorePk> {

    @Query("SELECT COUNT(s) FROM Store s WHERE s.book.ISBN = ?1 AND s.stock > 0")
    Long existsByBookIsbnAndStockGreaterThanZero(String isbn);

    @Query("SELECT s FROM Store s WHERE s.book.ISBN = ?1 AND s.stock > 0")
    Optional<List<Store>> shoWithBookAvailable (String isbn);
}

