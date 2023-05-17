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

    @SqlQuery("SELECT * FROM ORDERS ORDER BY ORDER_DATE DESC")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersOrderByReverseOrderDate();

    @SqlQuery("SELECT * FROM ORDERS JOIN CLIENTS ON ORDERS.ID_CLIENT = CLIENTS.ID_CLIENT ORDER BY ORDERS.ORDER_DATE, CLIENTS.FAMILY_NAME, CLIENTS.FIRST_NAME")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersOrderByDateThenClient();

    @SqlQuery("SELECT * FROM ORDERS WHERE ID_CLIENT = ?")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersByClient(String id);

    @SqlQuery("SELECT * FROM ORDERS WHERE ID_VIDEOGAME = ?")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersByVideogame(String id);

    @SqlQuery("SELECT * FROM ORDERS JOIN CLIENTS ON ORDERS.ID_CLIENT = CLIENTS.ID_CLIENT JOIN VIDEOGAMES ON ORDERS.ID_VIDEOGAME = VIDEOGAMES.ID_VIDEOGAME WHERE UPPER(CLIENTS.FIRST_NAME || ' ' || CLIENTS.FAMILY_NAME) LIKE UPPER('%' || ? || '%') AND UPPER(VIDEOGAMES.NAME) LIKE UPPER('%' || ? || '%') ORDER BY ORDERS.ORDER_DATE DESC, CLIENTS.FAMILY_NAME, CLIENTS.FIRST_NAME")
    @UseRowMapper(OrderMapper.class)
    List<Order> getOrdersByBothFullNames(String clientFullName, String videogameName);

    @SqlQuery("SELECT * FROM ORDERS WHERE ID_ORDER = ?")
    @UseRowMapper(OrderMapper.class)
    Order getOrder(String id);

    @SqlUpdate("INSERT INTO ORDERS (ID_CLIENT, ID_VIDEOGAME, ORDER_DATE) VALUES (?, ?, ?)")
    void addOrder(String clientId, String videogameId, LocalDate orderDate);

    @SqlUpdate("UPDATE ORDERS SET ID_CLIENT = ?, ID_VIDEOGAME = ?, ORDER_DATE = ? WHERE ID_ORDER = ?")
    void modifyOrder(String clientId, String videogameId, LocalDate orderDate, String id);

    @SqlQuery("SELECT EXISTS(SELECT 1 FROM ORDERS WHERE ID_ORDER = ?)")
    boolean isOrder(String id);

    @SqlUpdate("DELETE FROM ORDERS WHERE ID_ORDER = ?")
    void deleteOrder(String id);
}
