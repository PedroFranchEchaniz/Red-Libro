package com.example.redlibro.store.controller;

import com.example.redlibro.book.exception.BookNotFoundException;
import com.example.redlibro.rating.dto.GetRatingDto;
import com.example.redlibro.store.dto.AllStoreDto;
import com.example.redlibro.store.dto.ChangeAmountStore;
import com.example.redlibro.store.dto.NewStoreRequest;
import com.example.redlibro.store.exception.StoreNotFoundException;
import com.example.redlibro.store.model.Store;
import com.example.redlibro.store.model.StorePk;
import com.example.redlibro.store.repository.StoreRepository;
import com.example.redlibro.store.service.StoreService;
import com.example.redlibro.user.dto.ClienteResponse;
import com.example.redlibro.user.dto.CreateClientRequest;
import com.example.redlibro.user.dto.GetShopDtoDetail;
import com.example.redlibro.user.model.Client;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ReactiveAdapterRegistry;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Obtener store de una tienda", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                              "content": [
                                                {
                                                  "pk": "123456",
                                                  "isbn": "978-3-16-148410-0",
                                                  "titulo": "Libro de Ejemplo",
                                                  "cantidad": 10,
                                                  "uuid": "123e4567-e89b-12d3-a456-426614174000"
                                                },
                                                {
                                                  "pk": "654321",
                                                  "isbn": "978-1-4028-9462-6",
                                                  "titulo": "Otro Libro de Ejemplo",
                                                  "cantidad": 5,
                                                  "uuid": "123e4567-e89b-12d3-a456-426614174001"
                                                }
                                              ],
                                              "pageable": {
                                                "sort": {
                                                  "sorted": true,
                                                  "unsorted": false,
                                                  "empty": false
                                                },
                                                "pageNumber": 0,
                                                "pageSize": 20,
                                                "offset": 0,
                                                "paged": true,
                                                "unpaged": false
                                              },
                                              "totalElements": 2,
                                              "totalPages": 1,
                                              "last": true,
                                              "first": true,
                                              "numberOfElements": 2,
                                              "size": 20,
                                              "number": 0,
                                              "sort": {
                                                "sorted": true,
                                                "unsorted": false,
                                                "empty": false
                                              },
                                              "empty": false
                                            }
                                                                                        
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Store not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @Operation(summary = "NewRating", description = "Añadir valoracion")
    @GetMapping("store/{shopUuid}/stores")
    public ResponseEntity<Page<AllStoreDto>> getStoresByShopUuid(@PathVariable UUID shopUuid, @PageableDefault(page=0, size=4) Pageable pageable) {
        Page<Store> stores = storeService.findStoresByShopUuid(shopUuid, pageable);
        if (stores.isEmpty()) {
            throw new StoreNotFoundException();
        }
        Page<AllStoreDto> storeDtos = stores.map(AllStoreDto::fromStore);
        return ResponseEntity.ok(storeDtos);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Editar la cantidad de un libro en el store", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                              "pk": "1234",
                                              "isbn": "978-3-16-148410-0",
                                              "titulo": "Ejemplo de Libro",
                                              "cantidad": 10,
                                              "uuid": "f47ac10b-58cc-4372-a567-0e02b2c3d479"
                                            }
                                                                                        
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Book not found with ISBN: ", content = @Content),
            @ApiResponse(responseCode = "500", description = "Internal server error", content = @Content)
    })
    @PutMapping("store/edit/{isbn}")
    public AllStoreDto changeAmountStore(@PathVariable String isbn,@RequestBody ChangeAmountStore changeAmountStore){
        return AllStoreDto.fromStore(storeService.EditAmounStore(isbn, changeAmountStore));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Agregar libro a Store", content = {
                    @Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetRatingDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            {
                                              "pk": "1234",
                                              "isbn": "978-3-16-148410-0",
                                              "titulo": "Ejemplo de Libro",
                                              "cantidad": 10,
                                              "uuid": "f47ac10b-58cc-4372-a567-0e02b2c3d479"
                                            }
                                                                                        
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404", description = "Book not found with ISBN: ", content = @Content),
            @ApiResponse(responseCode = "404", description = "Shop not found with UUID; ", content = @Content),
            @ApiResponse(responseCode = "500", description = "Internal server error", content = @Content)

    })
    @PostMapping("store/newStore")
    public AllStoreDto newStore (@RequestBody NewStoreRequest newStoreRequest){
        return AllStoreDto.fromStore(storeService.newBookInStore(newStoreRequest));
    }


}
