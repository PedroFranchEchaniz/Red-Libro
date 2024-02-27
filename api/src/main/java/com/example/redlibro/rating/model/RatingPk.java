package com.example.redlibro.rating.model;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@Data
@NoArgsConstructor
public class RatingPk implements Serializable {
    private String clientId;
    private String bookIsbn;
}
