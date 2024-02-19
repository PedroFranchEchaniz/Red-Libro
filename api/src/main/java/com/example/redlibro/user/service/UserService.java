package com.example.redlibro.user.service;

import com.example.redlibro.user.model.User;
import com.example.redlibro.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

public Optional<User> findById(UUID id){
    return userRepository.findById(id);
}
}
