package com.example.redlibro.user.service;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.booking.dto.GetBookingDto;
import com.example.redlibro.shelving.Repository.ShelvingRepository;
import com.example.redlibro.shelving.dto.BooksInshelvingDto;
import com.example.redlibro.shelving.dto.ShelvingDto;
import com.example.redlibro.user.dto.CreateClientRequest;
import com.example.redlibro.user.dto.CreateShopRequest;
import com.example.redlibro.user.dto.GetClienteDtoDetail;
import com.example.redlibro.user.exception.PasswordNotValidException;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.model.Shop;
import com.example.redlibro.user.model.UserModel;
import com.example.redlibro.user.model.UserRol;
import com.example.redlibro.user.repository.ClientRepository;
import com.example.redlibro.user.repository.ShopRepository;
import com.example.redlibro.user.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;
    private final ClientRepository clientRepository;
    private final ShopRepository shopRepository;
    private final ShelvingRepository shelvingRepository;

    public Client createClient(CreateClientRequest createUserReques) {
        if (userRepository.existsByUsernameIgnoreCase(createUserReques.username()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El usuario ya esta registrado");
        if (!createUserReques.password().equalsIgnoreCase(createUserReques.verifyPassword())) {
            throw new PasswordNotValidException();
        }
        Client c = Client.builder()
                .username(createUserReques.username())
                .password(passwordEncoder.encode(createUserReques.password()))
                .lastName(createUserReques.lastName())
                .name(createUserReques.name())
                .avatar(createUserReques.avatar())
                .roles(Set.of(UserRol.User))
                .build();
        return clientRepository.save(c);
    }

    public Shop createShop(CreateShopRequest createShopRequest) {
        if (userRepository.existsByUsernameIgnoreCase(createShopRequest.username()))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "El usuario ya esta registrado");
        if (!createShopRequest.password().equalsIgnoreCase(createShopRequest.verifyPassword())) {
            throw new PasswordNotValidException();
        }
        Shop s = Shop.builder()
                .username(createShopRequest.username())
                .password(createShopRequest.password())
                .name(createShopRequest.name())
                .contacto(createShopRequest.contacto())
                .direccion(createShopRequest.direcction())
                .lat(createShopRequest.lat())
                .lon(createShopRequest.lon())
                .avatar(createShopRequest.avatar())
                .roles(Set.of(UserRol.Shop))
                .build();

        return shopRepository.save(s);
    }

    public List<UserModel> findAll() {
        return userRepository.findAll();
    }

    public Optional<UserModel> findById(UUID id) {
        return userRepository.findById(id);
    }

    public Optional<UserModel> findByUsername(String username) {
        return userRepository.findFirstByUsername(username);
    }


    public Optional<UserModel> editPassword(UUID userId, String newPassword) {


        return userRepository.findById(userId)
                .map(u -> {
                    u.setPassword(passwordEncoder.encode(newPassword));
                    return userRepository.save(u);
                });

    }

    public void delete(UserModel user) {
        deleteById(user.getUuid());
    }

    public void deleteById(UUID id) {
        if (userRepository.existsById(id))
            userRepository.deleteById(id);
    }

    public boolean passwordMatch(UserModel user, String clearPassword) {
        return passwordEncoder.matches(clearPassword, user.getPassword());
    }

    @Transactional
    public GetClienteDtoDetail getClienteDetail(UUID clientUuid) {
        Client client = clientRepository.findClientWithRatings(clientUuid)
                .orElseThrow(() -> new EntityNotFoundException("Cliente no encontrado"));


        List<GetBookingDto> bookingDtos = clientRepository.findBookingsByClientUuid(clientUuid);

        return new GetClienteDtoDetail(
                client.getUuid().toString(),
                client.getName(),
                client.getLastName(),
                client.getAvatar(),
                client.getUsername(),
                new HashSet<>(bookingDtos)
        );
    }

    public Boolean bookInShelving(String isbn) {
        if(shelvingRepository.isbnIsPresent(isbn)>0)
            return true;
        return false;
    }

    public List<BooksInshelvingDto> booksInShelving(UUID uuid){
        return shelvingRepository.shelvingOfClient(uuid)
                .stream()
                .map(book -> BooksInshelvingDto.of(book))
                .collect(Collectors.toList());
    }
}