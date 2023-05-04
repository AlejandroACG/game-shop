package com.svalero.dao;

import com.svalero.domain.Order;
import com.svalero.domain.Videogame;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

import static com.svalero.dao.Database.db;

public class VideogameMapper implements RowMapper<Videogame> {

    @Override
    public Videogame map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Videogame(rs.getInt("id"),
                rs.getString("name"),
                rs.getDate("releaseDate").toLocalDate(),
                rs.getDouble("price"));
    }
}
