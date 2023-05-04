package com.svalero.dao;
import com.svalero.domain.Client;
import com.svalero.domain.Order;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientMapper implements RowMapper<Client> {
    @Override
    public Client map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Client(rs.getInt("id"),
                rs.getString("firstName"),
                rs.getString("familyName"),
                rs.getDate("birthDate").toLocalDate(),
                rs.getString("email"),
                rs.getString("dni"));
    }
}
