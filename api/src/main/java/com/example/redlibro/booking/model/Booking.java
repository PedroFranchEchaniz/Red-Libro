package com.example.redlibro.booking.model;

import com.example.redlibro.store.model.Store;
import com.example.redlibro.user.model.Client;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Booking {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    @Column(columnDefinition = "uuid")
    private UUID uuid;

    @ManyToOne
    @JoinColumn(name = "client_uuid", referencedColumnName = "uuid")
    private Client client;

    @Column(nullable = false)
    private UUID bookingCode = UUID.randomUUID();

    @ManyToOne
    @JoinColumns({
            @JoinColumn(name = "shop_uuid", referencedColumnName = "shopUuid", insertable = false, updatable = false),
            @JoinColumn(name = "book_isbn", referencedColumnName = "bookIsbn", insertable = false, updatable = false)
    })
    private Store store;
}
