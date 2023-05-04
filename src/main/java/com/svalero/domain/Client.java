package com.svalero.domain;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
@NoArgsConstructor
public class Client {
    private int id;
    @NonNull
    private String firstName;
    @NonNull
    private String familyName;
    @NonNull
    private LocalDate birthDate;
    @NonNull
    private String email;
    @NonNull
    private String dni;
    @NonNull
    private List<Order> orders;
}
