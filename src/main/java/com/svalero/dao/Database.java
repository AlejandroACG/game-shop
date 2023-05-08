package com.svalero.dao;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.sql.SQLException;

import static com.svalero.util.Constants.*;

public class Database {
    public static Jdbi jdbi;
    public static Handle db;
    public static void connect() throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        jdbi = Jdbi.create(DATABASE_URL, DATABASE_USERNAME, DATABASE_PASSWORD);
        jdbi.installPlugin(new SqlObjectPlugin());
        db = jdbi.open();
    }

    public static void close() { db.close(); }
}
