package com.example.redlibro.book.service;

import com.example.redlibro.book.dto.CreateBookRequest;
import com.example.redlibro.book.dto.GetBookDto;
import com.example.redlibro.book.model.Book;
import com.example.redlibro.book.model.Genre;
import com.example.redlibro.book.repository.BookRepository;
import com.example.redlibro.rating.repository.RatingRepository;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.user.model.Shop;
import com.example.redlibro.user.repository.ShopRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.apache.el.parser.AstTrue;
import org.springframework.stereotype.Service;

import java.sql.Array;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookService {

    private final BookRepository bookRepository;
    private final RatingRepository ratingRepository;
    private final ShopRepository shopRepository;
    private final StoreRepository storeRepository;

    public Book createBook(CreateBookRequest createBookRequest) {
        boolean disponible = createBookRequest.stock() > 0;


        if (bookRepository.findById(createBookRequest.ISBN()).isPresent())
            return null;
        Set<Genre> genres = Arrays.stream(createBookRequest.genres())
                .map(Genre::valueOf)
                .collect(Collectors.toSet());
        LocalDate fecha = LocalDate.parse(createBookRequest.fecha());

        Book b = Book.builder()
                .ISBN(createBookRequest.ISBN())
                .titulo(createBookRequest.titulo())
                .autor(createBookRequest.autor())
                .editorial(createBookRequest.editorial())
                .portada(createBookRequest.portda())
                .genres(genres)
                .fecha(fecha)
                .fechaAlta(LocalDate.now())
                .mediaValoracion(0.0)
                .disponible(disponible)
                .build();
        bookRepository.save(b);
        Shop shop = shopRepository.findById(UUID.fromString(createBookRequest.uuidShor()))
                .orElseThrow(() -> new RuntimeException("Tienda no encontrada"));
        Store store = new Store();
        StorePk storePk = new StorePk();
        storePk.setShopUuid(UUID.fromString(createBookRequest.uuidShor()));
        storePk.setBookIsbn(createBookRequest.ISBN());
        store.setStorePk(storePk);
        store.setStock(createBookRequest.stock());
        store.setDateRegiste(LocalDate.now());
        store.setBook(b);
        store.setShop(shop);
        storeRepository.save(store);
       return b;
    }

   public List<Book>[] librosOrdenados (){
        List<Book>[] arrayBooks = (List<Book>[])new List<?>[5];

        arrayBooks[0] = bookRepository.fantasybooks();
        arrayBooks[1] = bookRepository.detectivebooks();
        arrayBooks[4] = bookRepository.syfybooks();

       for (int i = 0; i < arrayBooks.length; i++) {
           if (arrayBooks[i] == null) {
               arrayBooks[i] = new ArrayList<>();
           }
       }
       List<String> allIsbns = Arrays.stream(arrayBooks)
               .filter(Objects::nonNull)
               .flatMap(List::stream)
               .map(Book::getISBN)
               .collect(Collectors.toList());
       List<Object[]> avgRatings = ratingRepository.findAvgRatingsForBooks(allIsbns);
       Map<String, Double> isbnToAvgRating = avgRatings.stream()
               .collect(Collectors.toMap(
                       avgRating -> (String) avgRating[0],
                       avgRating -> (Double) avgRating[1]
               ));
       Arrays.stream(arrayBooks)
               .filter(Objects::nonNull)
               .flatMap(List::stream)
               .forEach(book -> book.setMediaValoracion(isbnToAvgRating.getOrDefault(book.getISBN(), 0.0)));

       for (List<Book> books : arrayBooks) {
           if (books != null) {
               for (Book book : books) {
                   boolean disponible = existsByBookIsbnAndStockGreaterThanZero(book.getISBN());
                   book.setDisponible(disponible);
               }
           }
       }
       return arrayBooks;
    }

    public Book libroMedia(String isbn) {
        Optional<Book> b = bookRepository.findById(isbn);
        if (b.isPresent()) {
            Book bookEncontrado = b.get();
            Optional<Double> avgRating = ratingRepository.bookAvgRating(isbn);
            if (avgRating.isPresent()) {
                double average = avgRating.get();
                bookEncontrado.setMediaValoracion(average);
            } else {
                bookEncontrado.setMediaValoracion(0.0);
            }
            return bookEncontrado;
        } else {
            return null;
        }
    }

    public boolean existsByBookIsbnAndStockGreaterThanZero(String isbn) {
        Long count = storeRepository.existsByBookIsbnAndStockGreaterThanZero(isbn);
        return count != null && count > 0;
    }

    public List<Store> shopsWithBook (String isbn){
        Optional<List<Store>> listaTiendas = storeRepository.shoWithBookAvailable(isbn);
        if(listaTiendas.isEmpty())
            return null;
        List<Store> listasEncontrdas = listaTiendas.get();
        return listasEncontrdas;
    }



}
