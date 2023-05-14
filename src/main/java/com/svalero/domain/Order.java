package com.svalero.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@NoArgsConstructor
public class Order {
    private String id;
    @NonNull
    private LocalDate orderDate;
    @NonNull
    private Client client;
    @NonNull
    private Videogame videogame;
}
