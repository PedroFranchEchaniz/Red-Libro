package com.example.redlibro.rating.model;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.UUID;

@Embeddable
@Getter
@Setter
@Data
@NoArgsConstructor
public class RatingPk implements Serializable {
    private UUID clientId;
    private String bookIsbn;
}
