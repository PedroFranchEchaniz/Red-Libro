package com.example.redlibro.user.repository;

import com.example.redlibro.user.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository <UserModel, UUID> {
    boolean existsByUsernameIgnoreCase(String username);

    Optional<UserModel> findFirstByUsername(String userbane);
}
