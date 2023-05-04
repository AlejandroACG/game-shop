package com.svalero.dao;
import com.svalero.domain.Order;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.time.LocalDate;
import java.util.List;

public class VideogameDAO {
    public interface ClientDAO {
        @SqlQuery("SELECT * FROM VIDEOGAMES")
        @UseRowMapper(OrderMapper.class)
        List<Order> getVideogames();

        @SqlUpdate("INSERT INTO VIDEOGAMES (NAME, RELEASE_DATE, PRICE) VALUES (?, ?, ?)")
        void addVideogame(String name, LocalDate releaseDate, double price);

        @SqlUpdate("DELETE FROM VIDEOGAMES WHERE ID_VIDEOGAME = ?")
        void deleteClient(int id);
    }



//    public void register(Videogame videogame) throws SQLException {
//        String sql = "INSERT INTO VIDEOGAMES (NAME, RELEASE_DATE, PRICE) VALUES (?, ?, ?)";
//        db.execute(sql,
//                videogame.getName(),
//                videogame.getReleaseDate(),
//                videogame.getPrice());
//    }
//
//    public List<Videogame> searchVideogames(String name) throws SQLException {
//        String sql = "SELECT * FROM VIDEOGAMES WHERE NAME = ?";
//
//        return db.createQuery(sql)
//                .bind(0, name)
//                .mapToBean(Videogame.class)
//                .list();
//    }
//
////    public boolean modifyVideogame(Videogame videogame) throws SQLException {
////        String sql = "UPDATE VIDEOGAMES SET NAME = ?, RELEASE_DATE = ?, PRICE = ? WHERE ...";
////
////        return;
////    }
//
//    public boolean deleteVideogame(String name, LocalDate releaseDate) throws SQLException {
//        String sql = "DELETE FROM VIDEOGAMES WHERE NAME = ? AND RELEASE_DATE = ?";
//        int count = db.createUpdate(sql)
//                .bind(0, name)
//                .bind(1, releaseDate)
//                .execute();
//        return count != 0;
//    }
//
//    public List<Videogame> getAllVideogames() throws SQLException {
//        List<Videogame> vehicleList = new ArrayList<>();
//        String sql = "SELECT * FROM VIDEOGAMES";
//
//        return db.createQuery(sql)
//                .mapToBean(Videogame.class)
//                .list();
//
//    }
//
//    public boolean isVideogame(String name) throws SQLException {
//        String sql = "SELECT COUNT(*) FROM VIDEOGAMES WHERE NAME = ?";
//        long count = db.createQuery(sql)
//                .bind(0, name)
//                .mapTo(long.class)
//                .one();
//        return count != 0;
//    }
//
////    private List<Videogame> select(String sql) {
////
////    }
}
