package com.example.redlibro.book.controller;

import com.example.redlibro.book.dto.*;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
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

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtener libros con valoración", content = {
                    @Content(mediaType = "application/json",
                    array = @ArraySchema(schema = @Schema(implementation = GetBookWithRating.class)),
                    examples = {@ExampleObject(
                            value = """
                                    [
                                        {
                                            "isbn": "1234567890",
                                            "titulo": "El SeÃ±or de los Anillos",
                                            "autor": "J.R.R. Tolkien",
                                            "editorial": "Minotauro",
                                            "fecha": "1891-06-02",
                                            "fechaAlta": "2023-01-19",
                                            "portada": "https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg",
                                            "genres": [
                                                "Fantasia"
                                            ],
                                            "resumen": "En la conclusiÃ³n Ã©pica de \\"El SeÃ±or de los Anillos\\", Frodo y Sam, guiados por Gollum, continÃºan su peligrosa misiÃ³n hacia el Monte del Destino para destruir el Anillo Ãšnico. Mientras, Aragorn lidera a los Pueblos Libres en la batalla final contra las fuerzas de Sauron en Minas Tirith. Es una lucha desesperada por la libertad y la esperanza, con el destino de la Tierra Media en la balanza. J.R.R. Tolkien cierra su obra maestra con heroÃ­smo, sacrificio y la promesa de paz tras la oscuridad.",
                                            "valoracion": 5.0,
                                            "disponible": true,
                                            "fechaEdicion": null,
                                            "nombreTienda": null
                                        },
                                        {
                                            "isbn": "1234567891",
                                            "titulo": "Guia del autoestopista intergalactico",
                                            "autor": "Douglas Adams",
                                            "editorial": "Anagrama",
                                            "fecha": "1999-06-02",
                                            "fechaAlta": "2024-02-22",
                                            "portada": "https://quelibroleo.com/images/libros/libro_1384705967.jpg",
                                            "genres": [
                                                "Cienciaficcion"
                                            ],
                                            "resumen": "DescripciÃ³n del libro Guia del autoestopista intergalactico",
                                            "valoracion": 5.0,
                                            "disponible": true,
                                            "fechaEdicion": null,
                                            "nombreTienda": null
                                        }
                                    ]
                                    """
                    )}
            )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
    @GetMapping("/book/allBooks")
    public List<GetBookWithRating> allBooks(){
        return bookRepository.findAll().stream()
                .map(GetBookWithRating::of)
                .toList();
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtener libros ordenados por genero ", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookAndRating.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               [
                                                    [
                                                        {
                                                            "isbn": "1234567890",
                                                            "titulo": "El SeÃ±or de los Anillos",
                                                            "autor": "J.R.R. Tolkien",
                                                            "editorial": "Minotauro",
                                                            "fecha": "1891-06-02",
                                                            "fechaAlta": "2023-01-19",
                                                            "portada": "https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg",
                                                            "genres": "[Fantasia]",
                                                            "resumen": "En la conclusiÃ³n Ã©pica de \\"El SeÃ±or de los Anillos\\", Frodo y Sam, guiados por Gollum, continÃºan su peligrosa misiÃ³n hacia el Monte del Destino para destruir el Anillo Ãšnico. Mientras, Aragorn lidera a los Pueblos Libres en la batalla final contra las fuerzas de Sauron en Minas Tirith. Es una lucha desesperada por la libertad y la esperanza, con el destino de la Tierra Media en la balanza. J.R.R. Tolkien cierra su obra maestra con heroÃ­smo, sacrificio y la promesa de paz tras la oscuridad.",
                                                            "valoracion": 5.0,
                                                            "disponible": true,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": [
                                                                {
                                                                    "userName": "username2",
                                                                    "valoracion": 5.0,
                                                                    "comentario": "Esta genial"
                                                                },
                                                                {
                                                                    "userName": "username",
                                                                    "valoracion": 4.0,
                                                                    "comentario": "Lo mejor que he leido"
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            "isbn": "9780307474728",
                                                            "titulo": "Cien anios de soledad",
                                                            "autor": "Gabriel GarcÃ­a MÃ¡rquez",
                                                            "editorial": "Vintage EspaÃ±ol",
                                                            "fecha": "1967-06-05",
                                                            "fechaAlta": "2024-02-23",
                                                            "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                            "genres": "[Fantasia]",
                                                            "resumen": "DescripciÃ³n del libro Cien anios de soledad",
                                                            "valoracion": 0.0,
                                                            "disponible": true,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": []
                                                        }
                                                    ],
                                                    [
                                                        {
                                                            "isbn": "9781503290563",
                                                            "titulo": "Orgullo y prejuicio",
                                                            "autor": "Jane Austen",
                                                            "editorial": "CreateSpace Independent Publishing Platform",
                                                            "fecha": "1813-01-28",
                                                            "fechaAlta": "2024-02-23",
                                                            "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                            "genres": "[Policiaca]",
                                                            "resumen": "DescripciÃ³n del libro Orgullo y prejuicio",
                                                            "valoracion": 0.0,
                                                            "disponible": true,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": []
                                                        },
                                                        {
                                                            "isbn": "9783333333333",
                                                            "titulo": "El Enigma de la Esfinge",
                                                            "autor": "Sarah Stone",
                                                            "editorial": "Aventuras Eternas",
                                                            "fecha": "2024-02-28",
                                                            "fechaAlta": "2024-02-28",
                                                            "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                            "genres": "[Policiaca]",
                                                            "resumen": "Descubre los misterios que esconde la antigua esfinge a travÃ©s de los ojos de nuestra heroÃ­na, en una aventura que combina historia, mitologÃ­a y suspense.",
                                                            "valoracion": 0.0,
                                                            "disponible": false,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": [
                                                                {
                                                                    "userName": "username",
                                                                    "valoracion": 5.0,
                                                                    "comentario": "Lo volverÃ­a a comprar"
                                                                }
                                                            ]
                                                        },
                                                        {
                                                            "isbn": "97833333333334",
                                                            "titulo": "El Enigma de la Esfinge",
                                                            "autor": "Sarah Stone",
                                                            "editorial": "Aventuras Eternas",
                                                            "fecha": "2024-02-28",
                                                            "fechaAlta": "2024-02-28",
                                                            "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                            "genres": "[Policiaca]",
                                                            "resumen": "Descubre los misterios que esconde la antigua esfinge a travÃ©s de los ojos de nuestra heroÃ­na, en una aventura que combina historia, mitologÃ­a y suspense.",
                                                            "valoracion": 0.0,
                                                            "disponible": false,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": []
                                                        }
                                                     ],
                                                    [],
                                                    [],
                                                    [
                                                        {
                                                            "isbn": "1234567891",
                                                            "titulo": "Guia del autoestopista intergalactico",
                                                            "autor": "Douglas Adams",
                                                            "editorial": "Anagrama",
                                                            "fecha": "1999-06-02",
                                                            "fechaAlta": "2024-02-22",
                                                            "portada": "https://quelibroleo.com/images/libros/libro_1384705967.jpg",
                                                            "genres": "[Cienciaficcion]",
                                                            "resumen": "DescripciÃ³n del libro Guia del autoestopista intergalactico",
                                                            "valoracion": 5.0,
                                                            "disponible": true,
                                                            "fechaEdicion": null,
                                                            "nombreTienda": null,
                                                            "valoraciones": []
                                                        }
                                                    ]
                                               ]
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
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

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Encontrar libro por Isbn", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookAndRating.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                    "isbn": "1234567890",
                                                    "titulo": "El SeÃ±or de los Anillos",
                                                    "autor": "J.R.R. Tolkien",
                                                    "editorial": "Minotauro",
                                                    "fecha": "1891-06-02",
                                                    "fechaAlta": "2023-01-19",
                                                    "portada": "https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg",
                                                    "genres": "[Fantasia]",
                                                    "resumen": "En la conclusiÃ³n Ã©pica de \\"El SeÃ±or de los Anillos\\", Frodo y Sam, guiados por Gollum, continÃºan su peligrosa misiÃ³n hacia el Monte del Destino para destruir el Anillo Ãšnico. Mientras, Aragorn lidera a los Pueblos Libres en la batalla final contra las fuerzas de Sauron en Minas Tirith. Es una lucha desesperada por la libertad y la esperanza, con el destino de la Tierra Media en la balanza. J.R.R. Tolkien cierra su obra maestra con heroÃ­smo, sacrificio y la promesa de paz tras la oscuridad.",
                                                    "valoracion": 5.0,
                                                    "disponible": true,
                                                    "fechaEdicion": null,
                                                    "nombreTienda": null,
                                                    "valoraciones": [
                                                        {
                                                            "userName": "username2",
                                                            "valoracion": 5.0,
                                                            "comentario": "Esta genial"
                                                        },
                                                        {
                                                            "userName": "username",
                                                            "valoracion": 4.0,
                                                            "comentario": "Lo mejor que he leido"
                                                        }
                                                    ]
                                                }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
    @GetMapping("/book/{isbn}")
    public GetBookAndRating detailsbook (@PathVariable String isbn)  {
        return bookService.getRatingsForBook(isbn);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tiendas con el libro disponible", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetShopWithBook.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               [
                                                   {
                                                       "name": "LibrerÃ­a Gandalf",
                                                       "direccion": "Calle Falsa 123",
                                                       "lat": "40.416775",
                                                       "lon": "-3.703790",
                                                       "precio": 22.0,
                                                       "uuid": "3fff85ce-354b-4e4c-bbc3-7ce138e573b6"
                                                   },
                                                   {
                                                       "name": "LibrerÃ­a Gandalf",
                                                       "direccion": "Calle Falsa 123",
                                                       "lat": "40.416100",
                                                       "lon": "-3.703790",
                                                       "precio": 22.0,
                                                       "uuid": "3fff85ce-354b-4e4c-bbc3-7ce138e573b7"
                                                   }
                                               ]
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
    @GetMapping("/book/avaibleInShop/{isbn}")
    public List<GetShopWithBook> shopWithBooks (@PathVariable String isbn){
        return bookService.shopsWithBook(isbn).stream()
                .map(GetShopWithBook::of)
                .toList();
    }


    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Tiendas con el libro disponible", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookWithRating.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               [
                                                    {
                                                        "isbn": "1234567890",
                                                        "titulo": "El SeÃ±or de los Anillos",
                                                        "autor": "J.R.R. Tolkien",
                                                        "editorial": "Minotauro",
                                                        "fecha": "1891-06-02",
                                                        "fechaAlta": "2023-01-19",
                                                        "portada": "https://m.media-amazon.com/images/I/91CZONTFNgL._SY342_.jpg",
                                                        "genres": [
                                                            "Fantasia"
                                                        ],
                                                        "resumen": "En la conclusiÃ³n Ã©pica de \\"El SeÃ±or de los Anillos\\", Frodo y Sam, guiados por Gollum, continÃºan su peligrosa misiÃ³n hacia el Monte del Destino para destruir el Anillo Ãšnico. Mientras, Aragorn lidera a los Pueblos Libres en la batalla final contra las fuerzas de Sauron en Minas Tirith. Es una lucha desesperada por la libertad y la esperanza, con el destino de la Tierra Media en la balanza. J.R.R. Tolkien cierra su obra maestra con heroÃ­smo, sacrificio y la promesa de paz tras la oscuridad.",
                                                        "valoracion": 5.0,
                                                        "disponible": true,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "1234567891",
                                                        "titulo": "Guia del autoestopista intergalactico",
                                                        "autor": "Douglas Adams",
                                                        "editorial": "Anagrama",
                                                        "fecha": "1999-06-02",
                                                        "fechaAlta": "2024-02-22",
                                                        "portada": "https://quelibroleo.com/images/libros/libro_1384705967.jpg",
                                                        "genres": [
                                                            "Cienciaficcion"
                                                        ],
                                                        "resumen": "DescripciÃ³n del libro Guia del autoestopista intergalactico",
                                                        "valoracion": 5.0,
                                                        "disponible": true,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "9780307474728",
                                                        "titulo": "Cien anios de soledad",
                                                        "autor": "Gabriel GarcÃ­a MÃ¡rquez",
                                                        "editorial": "Vintage EspaÃ±ol",
                                                        "fecha": "1967-06-05",
                                                        "fechaAlta": "2024-02-23",
                                                        "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                        "genres": [
                                                            "Fantasia"
                                                        ],
                                                        "resumen": "DescripciÃ³n del libro Cien anios de soledad",
                                                        "valoracion": 0.0,
                                                        "disponible": true,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "9781503290563",
                                                        "titulo": "Orgullo y prejuicio",
                                                        "autor": "Jane Austen",
                                                        "editorial": "CreateSpace Independent Publishing Platform",
                                                        "fecha": "1813-01-28",
                                                        "fechaAlta": "2024-02-23",
                                                        "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                        "genres": [
                                                            "Policiaca"
                                                        ],
                                                        "resumen": "DescripciÃ³n del libro Orgullo y prejuicio",
                                                        "valoracion": 0.0,
                                                        "disponible": true,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "9780060935467",
                                                        "titulo": "Matar a un ruisenioor",
                                                        "autor": "Harper Lee",
                                                        "editorial": "Harper Perennial Modern Classics",
                                                        "fecha": "1960-07-11",
                                                        "fechaAlta": "2024-02-23",
                                                        "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                        "genres": [
                                                            "Aventuras"
                                                        ],
                                                        "resumen": "DescripciÃ³n del libro Matar a un ruisenioor",
                                                        "valoracion": 0.0,
                                                        "disponible": true,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "9783333333333",
                                                        "titulo": "El Enigma de la Esfinge",
                                                        "autor": "Sarah Stone",
                                                        "editorial": "Aventuras Eternas",
                                                        "fecha": "2024-02-28",
                                                        "fechaAlta": "2024-02-28",
                                                        "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                        "genres": [
                                                            "Policiaca"
                                                        ],
                                                        "resumen": "Descubre los misterios que esconde la antigua esfinge a travÃ©s de los ojos de nuestra heroÃ­na, en una aventura que combina historia, mitologÃ­a y suspense.",
                                                        "valoracion": 0.0,
                                                        "disponible": false,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    },
                                                    {
                                                        "isbn": "97833333333334",
                                                        "titulo": "El Enigma de la Esfinge",
                                                        "autor": "Sarah Stone",
                                                        "editorial": "Aventuras Eternas",
                                                        "fecha": "2024-02-28",
                                                        "fechaAlta": "2024-02-28",
                                                        "portada": "URL_GENÃ‰RICA_DE_PORTADA",
                                                        "genres": [
                                                            "Policiaca"
                                                        ],
                                                        "resumen": "Descubre los misterios que esconde la antigua esfinge a travÃ©s de los ojos de nuestra heroÃ­na, en una aventura que combina historia, mitologÃ­a y suspense.",
                                                        "valoracion": 0.0,
                                                        "disponible": false,
                                                        "fechaEdicion": null,
                                                        "nombreTienda": null
                                                    }
                                                ]
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
    @GetMapping("book/getAll")
    public List<GetBookWithRating> getAllBooks (){
        return bookService.getAllBooks().stream()
                .map(GetBookWithRating::of)
                .toList();
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Editar un libro", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetBookDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                  "autor": "Douglas Adams",
                                                  "editorial": "Anagrama",
                                                  "fecha": "1999-06-02",
                                                  "fechaAlta": "2024-02-22",
                                                  "fechaEdicion": "2024-06-12T00:51:48.8488738",
                                                  "genres": ["Cienciaficcion"],
                                                  "isbn": "1234567891",
                                                  "nombreTienda": "Librería Gandalf",
                                                  "portada": "https://quelibroleo.com/images/libros/libro_1384705967.jpg",
                                                  "resumen": "Descripción del libro Guia del autoestopista intergalactico",
                                                  "titulo": "Guia del autoestopista intergalactico000",
                                                  "valoracion": null
                                                }
                                                
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "500"),
            @ApiResponse(responseCode = "500", description = "Libros no encontrados", content = @Content)
    })
   @PutMapping("book/edit/{isbn}")
    public GetBookDto editBook(@PathVariable String isbn, @RequestBody EditBookDto editBookDto){
        return GetBookDto.of(bookService.editBook(isbn, editBookDto));
    }

    @GetMapping("/book/filter")
    public List<GetBookWithRating> filterBooks(
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String autor,
            @RequestParam(required = false) String editorial,
            @RequestParam(required = false) Boolean disponible,
            @RequestParam(required = false) Genre genre) {
        return bookService.filterBooks(titulo, autor, editorial, disponible, genre);
    }

}
