package com.svalero.dao;
import com.svalero.domain.Order;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.time.LocalDate;
import java.util.List;

public interface ClientDAO {
    @SqlQuery("SELECT * FROM CLIENTS")
    @UseRowMapper(OrderMapper.class)
    List<Order> getClients();

    @SqlUpdate("INSERT INTO CLIENTS (FIRST_NAME, FAMILY_NAME, BIRTH_DATE, EMAIL, DNI) VALUES (?, ?, ?, ?, ?)")
    void addClient(String firstName, String familyName, LocalDate birthDate, String email, String dni);

    @SqlUpdate("DELETE FROM CLIENTS WHERE ID_CLIENT = ?")
    void deleteClient(int id);
}
