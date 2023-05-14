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

    @SqlQuery("SELECT * FROM VIDEOGAMES WHERE UPPER(NAME) LIKE UPPER('%' || ? || '%') AND PRICE <= ?")
    @UseRowMapper(VideogameMapper.class)
    List<Videogame> getVideogamesByNamePrice(String name, double price);

    @SqlQuery("SELECT * FROM VIDEOGAMES WHERE PRICE <= ?")
    @UseRowMapper(VideogameMapper.class)
    List<Videogame> getVideogamesByPrice(double price);

    @SqlQuery("SELECT * FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?")
    @UseRowMapper(VideogameMapper.class)
    Videogame getVideogame(String id);

    @SqlUpdate("INSERT INTO VIDEOGAMES (NAME, RELEASE_DATE, PRICE, PICTURE) VALUES (?, ?, ?, ?)")
    void addVideogame(String name, LocalDate releaseDate, double price, String picture);

    @SqlUpdate("UPDATE VIDEOGAMES SET NAME = ?, RELEASE_DATE = ?, PRICE = ?, PICTURE = ? WHERE ID_VIDEOGAME = ?")
    void modifyVideogame(String name, LocalDate releaseDate, double price, String picture, String id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?)")
    boolean isVideogame(String id);

    @SqlQuery("SELECT CEIL(MAX(PRICE)) AS MAX_PRICE FROM VIDEOGAMES")
    int getMaxPrice();

    @SqlUpdate("DELETE FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?")
    void deleteVideogame(String id);
}
