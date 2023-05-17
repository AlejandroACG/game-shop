package com.svalero.dao;
import com.svalero.domain.Client;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientMapper implements RowMapper<Client> {
    @Override
    public Client map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Client(rs.getString("ID_CLIENT"),
                rs.getString("FIRST_NAME"),
                rs.getString("FAMILY_NAME"),
                rs.getDate("BIRTH_DATE").toLocalDate(),
                rs.getString("EMAIL"),
                rs.getString("DNI"),
                rs.getString("PICTURE"));
    }
}
