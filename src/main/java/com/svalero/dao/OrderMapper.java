package com.svalero.dao;
import com.svalero.domain.Client;
import com.svalero.domain.Order;
import com.svalero.domain.Videogame;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import static com.svalero.dao.Database.jdbi;

public class OrderMapper implements RowMapper<Order> {
    @Override
    public Order map(ResultSet rs, StatementContext ctx) throws SQLException {
        ClientDAO clientDAO = jdbi.onDemand(ClientDAO.class);
        Client client = clientDAO.getClient(rs.getString("ID_CLIENT"));
        VideogameDAO videogameDAO = jdbi.onDemand(VideogameDAO.class);
        Videogame videogame = videogameDAO.getVideogame(rs.getString("ID_VIDEOGAME"));
        return new Order(rs.getString("ID_ORDER"),
                rs.getDate("ORDER_DATE").toLocalDate(),
                client,
                videogame);
    }
}
