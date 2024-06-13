package com.example.redlibro.store.repository;

import com.example.redlibro.store.dto.AllStoreDto;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.user.model.Shop;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface StoreRepository extends JpaRepository<Store, StorePk> {

    @Query("SELECT COUNT(s) FROM Store s WHERE s.book.ISBN = ?1 AND s.stock > 0")
    Long existsByBookIsbnAndStockGreaterThanZero(String isbn);

    @Query("SELECT s FROM Store s WHERE s.book.ISBN = ?1 AND s.stock > 0")
    Optional<List<Store>> shoWithBookAvailable (String isbn);

    @Query("SELECT s from Store s WHERE s.book.ISBN = ?1 AND s.shop.uuid = ?2")
    Optional<Store>shopBookStore(String isbn, UUID uuid);

    @Query("SELECT s from Store s WHERE s.shop.uuid = ?1")
    Page<Store> findStoresByShopUuid(UUID shopUuid, Pageable pageable);

    @Query("SELECT new com.example.redlibro.store.dto.AllStoreDto(" +
            "CAST(s.storePk AS string), " +
            "s.storePk.bookIsbn, " +
            "s.book.titulo, " +
            "s.stock, " +
            "s.shop.uuid) " +
            "FROM Store s WHERE s.shop.uuid = ?1")
    List<AllStoreDto> findAllStore(UUID shopUuid);

    @Query("SELECT s from Store s WHERE s.book.ISBN = ?1 AND s.shop.uuid = ?2")
    Optional<Store>getStoreByIsbn(String isbn, UUID uuid);






}

