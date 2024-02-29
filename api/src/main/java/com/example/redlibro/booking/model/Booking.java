package com.example.redlibro.booking.model;

import com.example.redlibro.store.model.Store;
import com.example.redlibro.user.model.Client;
import com.example.redlibro.user.model.Shop;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import java.time.LocalDate;
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
    @JoinColumn(name = "shop_uuid")
    private Shop shop;

    private LocalDate fechaReserva;

}
