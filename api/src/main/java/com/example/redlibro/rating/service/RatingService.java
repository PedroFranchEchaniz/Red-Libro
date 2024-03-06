package com.example.redlibro.rating.service;

import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.rating.dto.NewRatingDto;
import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.rating.model.RatingPk;
import com.example.redlibro.rating.repository.RatingRepository;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.repository.ClientRepository;
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



    public Rating newRating(UUID clientUui, String bookIsbn, NewRatingDto ratingDto){
        RatingPk ratingPk = new RatingPk();
        ratingPk.setBookIsbn(bookIsbn);
        ratingPk.setClientId(clientUui);

        Rating newRating = Rating.builder()
                .id(ratingPk)
                .stars(ratingDto.stars())
                .opinion(ratingDto.opinion())
                .book(bookRepository.findByIdWithRatings(bookIsbn).get())
                .client(clientRepository.findByUuidWithRatings(clientUui).get())
                .build();

        return ratingRepository.save(newRating);
    }
}
