package com.example.redlibro.shelving;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@Embeddable
public class ShelvingPk implements Serializable {

    private static final long serialVersionUID = 1L;

    private UUID client_uuid;
    private String book_isbn;
}
