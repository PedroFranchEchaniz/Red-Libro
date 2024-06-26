package com.example.redlibro.security.jwt.refresh;

import com.example.redlibro.user.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import java.util.Optional;
import java.util.UUID;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, UUID> {
    Optional<RefreshToken>findByToken(String token);

    @Modifying
    int deleteByUser(UserModel user);
}
