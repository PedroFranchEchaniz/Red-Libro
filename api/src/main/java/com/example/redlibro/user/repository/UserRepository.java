package com.example.redlibro.user.repository;

import com.example.redlibro.user.dto.AllClientsDto;
import com.example.redlibro.user.dto.UserDto;
import com.example.redlibro.user.model.UserModel;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository <UserModel, UUID> {
    boolean existsByUsernameIgnoreCase(String username);

    Optional<UserModel> findFirstByUsername(String userbane);

    @Query("SELECT new com.example.redlibro.user.dto.UserDto(c.uuid, c.username, c.enabled) FROM UserModel c JOIN c.roles r WHERE r = com.example.redlibro.user.model.UserRol.User")
    List<UserDto> getAllClients(Pageable pageable);

    @Query("SELECT new com.example.redlibro.user.dto.AllClientsDto(c.uuid, c.username) FROM UserModel c JOIN c.roles r WHERE r = com.example.redlibro.user.model.UserRol.User AND c.uuid = ?1")
    Optional<AllClientsDto> getClient(UUID uuid);

    @Query("SELECT c FROM UserModel c JOIN c.roles r WHERE r = com.example.redlibro.user.model.UserRol.User AND c.uuid = ?1")
    Optional<UserModel> getClientforBan(UUID uuid);


}
