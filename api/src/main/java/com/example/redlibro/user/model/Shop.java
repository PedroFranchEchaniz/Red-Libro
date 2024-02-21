
package com.example.redlibro.user.model;

import com.example.redlibro.store.Store;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Shop extends UserModel {

    private String name;
    private String direccion;
    private String contacto;
    private String lat;
    private String lon;

    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    @Builder.Default
    @OneToMany()
    private List<Store> stores = new ArrayList<>();

}