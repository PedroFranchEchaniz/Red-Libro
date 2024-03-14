package com.example.redlibro.rating.controller;

import com.example.redlibro.rating.dto.GetRatingDto;
import com.example.redlibro.rating.dto.NewRatingDto;
import com.example.redlibro.rating.model.Rating;
import com.example.redlibro.rating.service.RatingService;
import com.example.redlibro.user.model.Client;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Crear valoracion", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "userName": "username1",
                                                "valoracion": 4.0,
                                                "comentario": "muy buen libto"
                                            }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500", description = "Book not found with ISBN: ", content = @Content),
            @ApiResponse(responseCode = "500", description = "Client not found with UUID: ", content = @Content)
    })
    @Operation(summary = "NewRating", description = "Añadir valoracion")
    @PostMapping("/book/rating/{isbn}")
    public ResponseEntity<GetRatingDto>createRating(@AuthenticationPrincipal Client client, @PathVariable String isbn, @RequestBody NewRatingDto ratingDto){
        Rating rating = ratingService.newRating(client.getUuid(), isbn, ratingDto);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(GetRatingDto.of(rating));
    }
}
