package com.example.redlibro.store;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@Embeddable
public class StorePk implements Serializable {

    private static final long serialVersionUID = 1L;

    private UUID shop_uuid;
    private UUID book_isbn;
}
