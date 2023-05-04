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
    @NonNull
    int id;
    @NonNull
    private LocalDate orderDate;
    //TODO LO SIGUIENTE HAY QUE MAPEARLO EN EL MAPPER TAMBIÉN
//    @NonNull
//    private Videogame client;
//    @NonNull
//    private Videogame videogame;
}
