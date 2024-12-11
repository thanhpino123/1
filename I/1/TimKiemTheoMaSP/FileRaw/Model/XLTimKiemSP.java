package Model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import Model.sanpham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet(urlPatterns={"/XLTimKiemSP"})
public class XLTimKiemSP extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String maSP = request.getParameter("maSP");
        List<sanpham> sanPhams = new ArrayList<>();
        String message = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Kết nối cơ sở dữ liệu
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/qlsanpham", "username", "");

            // Truy vấn tìm kiếm sản phẩm
            String sql = "SELECT * FROM sanpham WHERE MaSP = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, maSP);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String maSanPham = rs.getString("MaSP");
                String tenSP = rs.getString("TenSP");
                int soLuong = rs.getInt("SoLuong");
                double donGia = rs.getDouble("DonGia");
                sanPhams.add(new sanpham(maSanPham, tenSP, soLuong, donGia));
            }

            if (sanPhams.isEmpty()) {
                message = "Không tìm thấy mã sản phẩm " + maSP;
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Có lỗi xảy ra, vui lòng thử lại sau!";
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Gửi dữ liệu về trang TimKiemSP.jsp
        request.setAttribute("sanPhams", sanPhams);
        request.setAttribute("message", message);
        request.getRequestDispatcher("TimKiemSP.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}