package com.example.redlibro.store.model;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@Embeddable
@Getter
@Setter
public class StorePk implements Serializable {

    private static final long serialVersionUID = 1L;

    private UUID shopUuid;
    private String bookIsbn;
}
