package com.svalero.dao;
import com.svalero.domain.Client;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.time.LocalDate;
import java.util.List;

public interface ClientDAO {
    @SqlQuery("SELECT * FROM CLIENTS")
    @UseRowMapper(ClientMapper.class)
    List<Client> getClients();

    @SqlQuery("SELECT * FROM CLIENTS WHERE ID_CLIENT = ?")
    @UseRowMapper(ClientMapper.class)
    Client getClient(int id);

    @SqlUpdate("INSERT INTO CLIENTS (FIRST_NAME, FAMILY_NAME, BIRTH_DATE, EMAIL, DNI) VALUES (?, ?, ?, ?, ?)")
    void addClient(String firstName, String familyName, LocalDate birthDate, String email, String dni);

    @SqlUpdate("UPDATE VIDEOGAMES SET FIRST_NAME = ?, FAMILY_NAME = ?, BIRTH_DATE = ?, EMAIL = ?, DNI = ? WHERE ID_CLIENT = ?")
    void modifyClient(String firstName, String familyName, LocalDate birthDate, String email, String dni, int id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM CLIENTS WHERE ID_CLIENT = ?)")
    boolean isClient(int id);

    @SqlUpdate("DELETE FROM CLIENTS WHERE ID_CLIENT = ?")
    void deleteClient(int id);
}
