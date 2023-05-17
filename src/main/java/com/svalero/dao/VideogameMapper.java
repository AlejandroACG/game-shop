package com.svalero.dao;
import com.svalero.domain.Videogame;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VideogameMapper implements RowMapper<Videogame> {
    @Override
    public Videogame map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Videogame(rs.getString("ID_VIDEOGAME"),
                rs.getString("NAME"),
                rs.getDate("RELEASE_DATE").toLocalDate(),
                rs.getDouble("PRICE"),
                rs.getString("PICTURE"));
    }
}
