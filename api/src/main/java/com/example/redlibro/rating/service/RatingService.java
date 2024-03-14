package com.example.redlibro.rating.service;

import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.rating.dto.NewRatingDto;
import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.rating.model.RatingPk;
import com.example.redlibro.rating.repository.RatingRepository;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.repository.ClientRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RatingService {

    private final RatingRepository ratingRepository;
    private final BookRepository bookRepository;
    private final ClientRepository clientRepository;



    @Transactional
    public Rating newRating(UUID clientUuid, String bookIsbn, NewRatingDto ratingDto) {
        if (!bookRepository.existsById(bookIsbn)) {
            throw new EntityNotFoundException("Book not found with ISBN: " + bookIsbn);
        }
        if (!clientRepository.existsById(clientUuid)) {
            throw new EntityNotFoundException("Client not found with UUID: " + clientUuid);
        }

        RatingPk ratingPk = new RatingPk();
        ratingPk.setBookIsbn(bookIsbn);
        ratingPk.setClientId(clientUuid);


        Rating newRating = Rating.builder()
                .id(ratingPk)
                .stars(ratingDto.stars())
                .opinion(ratingDto.opinion())
                .book(Book.builder()
                        .ISBN(bookIsbn)
                        .build())
                .client(Client.builder()
                        .uuid(clientUuid)
                        .build())
                .build();

        return ratingRepository.save(newRating);
    }
}
