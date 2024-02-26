
package com.example.redlibro.user.model;

import com.example.redlibro.store.Store;
import jakarta.persistence.*;
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
    @OneToMany(mappedBy = "shop", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Store> stores = new ArrayList<>();

}