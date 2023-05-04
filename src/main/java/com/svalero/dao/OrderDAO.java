package com.svalero.dao;
import com.svalero.domain.Order;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.time.LocalDate;
import java.util.List;

public interface OrderDAO {
    @SqlQuery("SELECT * FROM ORDERS")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrders();

    @SqlQuery("SELECT * FROM ORDERS WHERE ID_CLIENT = ?")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersByClient(int id);

    @SqlUpdate("INSERT INTO ORDERS (ORDER_DATE) VALUES (?)")
    void addOrder(LocalDate orderDate);

    @SqlUpdate("DELETE FROM ORDERS WHERE ID_ORDER = ?")
    void deleteOrder(int id);
}
