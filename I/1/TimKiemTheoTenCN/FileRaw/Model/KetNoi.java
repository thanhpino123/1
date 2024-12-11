package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KetNoi {

    private static final String URL = "jdbc:mysql://localhost:3306/qlcongnhan";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    public static Connection DataBase() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Không tìm thấy Driver JDBC");
        }
    }
}
