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

    @SqlQuery("SELECT * FROM CLIENTS ORDER BY FAMILY_NAME")
    @UseRowMapper(ClientMapper.class)
    List<Client> getClientsOrderByFamilyName();

    @SqlQuery("SELECT * FROM CLIENTS WHERE UPPER(FIRST_NAME || ' ' || FAMILY_NAME) LIKE UPPER('%' || ? || '%') ORDER BY FAMILY_NAME")
    @UseRowMapper(ClientMapper.class)
    List<Client> getClientsByFullNameOrderByFamilyName(String fullName);

    @SqlQuery("SELECT * FROM CLIENTS WHERE ID_CLIENT = ?")
    @UseRowMapper(ClientMapper.class)
    Client getClient(String id);

    @SqlUpdate("INSERT INTO CLIENTS (FIRST_NAME, FAMILY_NAME, BIRTH_DATE, EMAIL, DNI, PICTURE) VALUES (?, ?, ?, ?, ?, ?)")
    void addClient(String firstName, String familyName, LocalDate birthDate, String email, String dni, String picture);

    @SqlUpdate("UPDATE VIDEOGAMES SET FIRST_NAME = ?, FAMILY_NAME = ?, BIRTH_DATE = ?, EMAIL = ?, DNI = ?, PICTURE = ? WHERE ID_CLIENT = ?")
    void modifyClient(String firstName, String familyName, LocalDate birthDate, String email, String dni, String id, String picture);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM CLIENTS WHERE ID_CLIENT = ?)")
    boolean isClient(String id);

    @SqlUpdate("DELETE FROM CLIENTS WHERE ID_CLIENT = ?")
    void deleteClient(String id);
}
