package com.svalero.dao;
import com.svalero.domain.Order;
import com.svalero.domain.Videogame;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import static com.svalero.dao.Database.jdbi;

public class VideogameMapper implements RowMapper<Videogame> {
    @Override
    public Videogame map(ResultSet rs, StatementContext ctx) throws SQLException {
        int videogameId = rs.getInt("ID_VIDEOGAME");
        OrderDAO orderDAO = jdbi.onDemand(OrderDAO.class);
        List<Order> orders = orderDAO.getOrdersByVideogame(videogameId);
        return new Videogame(videogameId,
                rs.getString("NAME"),
                rs.getDate("RELEASE_DATE").toLocalDate(),
                rs.getDouble("PRICE"),
                orders);
    }
}
