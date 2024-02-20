package com.example.redlibro.user.repository;

import com.example.redlibro.user.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface ClientRepository extends JpaRepository<Client, UUID> {

    Optional<Client> findFirstByUsername(String username);
}
