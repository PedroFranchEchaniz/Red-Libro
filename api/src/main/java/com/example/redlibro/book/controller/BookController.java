package com.example.redlibro.book.controller;

import com.example.redlibro.book.dto.BookResponse;
import com.example.redlibro.book.dto.CreateBookRequest;
import com.example.redlibro.book.dto.GetBookDto;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.book.service.BookService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
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

    @PostMapping("/shop/newBook")
    public ResponseEntity<BookResponse>createBook(@Valid @RequestBody CreateBookRequest createBookRequest){
        Book book = bookService.createBook(createBookRequest);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(BookResponse.fromBook(book));
    }

    /*@GetMapping("/book/allBooks")
    public List<GetBookDto> allBooks(){
        return bookRepository.findAll().stream()
                .map(GetBookDto::of)
                .toList();
    }

    @GetMapping("/book/listsBooks")
    public List<GetBookDto> []allBooksArray(){
        List<Book>[] librosOrdenados = bookService.librosOrdenados();

        List<GetBookDto>[] dtoLists = Arrays.stream(librosOrdenados)
                .map(list -> list.stream().map(GetBookDto::of).collect(Collectors.toList()))
                .toArray(List[]::new);
        return dtoLists;
    }


    @GetMapping("/book/{isbn}")
        public GetBookDto detailsbook (@PathVariable String isbn)  {
        Optional<Book> b = bookRepository.findById(isbn);
        if(b == null)
            return null;
        return GetBookDto.of(b.get());
    }*/
}
