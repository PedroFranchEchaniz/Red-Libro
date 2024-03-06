package com.example.redlibro.rating.controller;

import com.example.redlibro.rating.dto.GetRatingDto;
import com.example.redlibro.rating.dto.NewRatingDto;
import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.rating.service.RatingService;
import com.example.redlibro.user.model.Client;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class RatingController {

    private final RatingService ratingService;

    @PostMapping("/book/rating/{isbn}")
    public ResponseEntity<GetRatingDto>createRating(@AuthenticationPrincipal Client client, @PathVariable String isbn, @RequestBody NewRatingDto ratingDto){
        Rating rating = ratingService.newRating(client.getUuid(), isbn, ratingDto);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(GetRatingDto.of(rating));
    }
}
