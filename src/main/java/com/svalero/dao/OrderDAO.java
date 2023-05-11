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

    @SqlQuery("SELECT * FROM ORDERS WHERE ID_VIDEOGAME = ?")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersByVideogame(int id);

    @SqlUpdate("INSERT INTO ORDERS (ID_CLIENT, ID_VIDEOGAME, ORDER_DATE) VALUES (?, ?, ?)")
    void addOrder(int clientId, int videogameId, LocalDate orderDate);

    @SqlUpdate("UPDATE ORDERS SET ID_CLIENT = ?, ID_VIDEOGAME = ?, ORDER_DATE = ? WHERE ID_ORDER = ?")
    void modifyOrder(String clientId, String videogameId, LocalDate orderDate, int id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM ORDERS WHERE ID_ORDER = ?)")
    boolean isOrder(int id);

    @SqlUpdate("DELETE FROM ORDERS WHERE ID_ORDER = ?")
    void deleteOrder(int id);
}
