package com.svalero.dao;
import com.svalero.domain.User;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

public interface UserDAO {
    @SqlQuery("SELECT * FROM USERS WHERE UPPER(USERNAME) = UPPER(?)")
    @UseRowMapper(UserMapper.class)
    User findUserByUsername(String username);
}
