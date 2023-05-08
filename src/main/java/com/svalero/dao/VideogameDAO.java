package com.svalero.dao;
import com.svalero.domain.Videogame;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.time.LocalDate;
import java.util.List;

public interface VideogameDAO {
    @SqlQuery("SELECT * FROM VIDEOGAMES")
    @UseRowMapper(VideogameMapper.class)
    List<Videogame> getVideogames();

    @SqlQuery("SELECT * FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?")
    @UseRowMapper(VideogameMapper.class)
    Videogame getVideogame(int id);

    @SqlUpdate("INSERT INTO VIDEOGAMES (NAME, RELEASE_DATE, PRICE) VALUES (?, ?, ?)")
    void addVideogame(String name, LocalDate releaseDate, double price);

    @SqlUpdate("UPDATE VIDEOGAMES SET NAME = ?, RELEASE_DATE = ?, PRICE = ? WHERE ID = ?")
    void modifyVideogame(String name, LocalDate releaseDate, double price, String id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM VIDEOGAMES WHERE ID = ?)")
    boolean isVideogame(String id);

    @SqlUpdate("DELETE FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?")
    void deleteVideogame(int id);
}
