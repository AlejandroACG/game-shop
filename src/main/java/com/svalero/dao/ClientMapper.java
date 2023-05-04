package com.svalero.dao;
import com.svalero.domain.Client;
import com.svalero.domain.Order;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static com.svalero.dao.Database.jdbi;

public class ClientMapper implements RowMapper<Client> {
    @Override
    public Client map(ResultSet rs, StatementContext ctx) throws SQLException {
        int clientId = rs.getInt("ID_CLIENT");
        OrderDAO orderDAO = jdbi.onDemand(OrderDAO.class);
        List<Order> orders = orderDAO.getOrdersByClient(rs.getInt("ID_CLIENT"));
        return new Client(clientId,
                rs.getString("FIRST_NAME"),
                rs.getString("FAMILY_NAME"),
                rs.getDate("BIRTH_DATE").toLocalDate(),
                rs.getString("EMAIL"),
                rs.getString("DNI"),
                orders);
    }
}
