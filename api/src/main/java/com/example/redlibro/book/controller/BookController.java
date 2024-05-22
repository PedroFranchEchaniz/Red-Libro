package com.example.redlibro.book.controller;

import com.example.redlibro.book.dto.*;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.book.service.BookService;
import com.example.redlibro.rating.dto.GetRatingDto;
import com.example.redlibro.user.dto.GetShopWithBook;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.hibernate.validator.constraints.ISBN;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
public class BookController {

    private final BookService bookService;
    private final BookRepository bookRepository;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Dar libro de alta", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                                "isbn": "1234567891",
                                                "title": "El nombre del viento",
                                                "editorial": "DAW Books",
                                                "fechaAlta": "2024-03-14"
                                            }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Tienda no encontrada", content = @Content)
    })
    @Operation(summary = "AddBook", description = "Añadir un nuevo libro")
    @PostMapping("/book/newBook")
    public ResponseEntity<BookResponse>createBook(@Valid @RequestBody CreateBookRequest createBookRequest){
        Book book = bookService.createBook(createBookRequest);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(BookResponse.fromBook(book));
    }

    @GetMapping("/book/allBooks")
    public List<GetBookWithRating> allBooks(){
        return bookRepository.findAll().stream()
                .map(GetBookWithRating::of)
                .toList();
    }

    @GetMapping("/book/listsBooks")
    public List<List<GetBookAndRating>> allBooksArray() {
        List<Book>[] librosOrdenados = bookService.librosOrdenados();
        List<List<GetBookAndRating>> dtoLists = Arrays.stream(librosOrdenados)
                .map(list -> list.stream()
                        .map(book -> bookService.getRatingsForBook(book.getISBN())) // Usar getRatingsForBook para obtener las valoraciones
                        .collect(Collectors.toList()))
                .collect(Collectors.toList()); // Cambio para retornar una lista de listas
        return dtoLists;
    }


    @GetMapping("/book/{isbn}")
    public GetBookAndRating detailsbook (@PathVariable String isbn)  {
        return bookService.getRatingsForBook(isbn);
    }

    @GetMapping("/book/avaibleInShop/{isbn}")
    public List<GetShopWithBook> shopWithBooks (@PathVariable String isbn){
        return bookService.shopsWithBook(isbn).stream()
                .map(GetShopWithBook::of)
                .toList();
    }

    @GetMapping("book/getAll")
    public List<GetBookWithRating> getAllBooks (){
        return bookService.getAllBooks().stream()
                .map(GetBookWithRating::of)
                .toList();
    }

}
