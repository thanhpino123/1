package Model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/XLTimKiemCN")
public class XLTimKiemCN extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận tham số từ request
        String hoTen = request.getParameter("hoTen");
        StringBuilder ketQua = new StringBuilder();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Mở kết nối
            conn = KetNoi.DataBase();

            // Truy vấn tìm công nhân
            String sql = "SELECT * FROM congnhan WHERE HoTen LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + hoTen + "%");
            rs = stmt.executeQuery();

            ArrayList<CongNhan> danhSach = new ArrayList<>();

            // Duyệt kết quả trả về
            while (rs.next()) {
                CongNhan cn = new CongNhan(
                    rs.getInt("MaCN"),
                    rs.getString("HoTen"),
                    rs.getString("GioiTinh"),
                    rs.getInt("SoGioLamVuot")
                );
                danhSach.add(cn);
            }

            // Xây dựng kết quả HTML để trả về JSP
            if (danhSach.isEmpty()) {
                ketQua.append("<p>Không tìm thấy công nhân có tên: ").append(hoTen).append("</p>");
            } else {
                ketQua.append("<table border='1'><tr>")
                      .append("<th>Mã CN</th><th>Họ Tên</th><th>Giới Tính</th><th>Số Giờ Làm</th><th>Tiền Thưởng</th></tr>");
                for (CongNhan cn : danhSach) {
                    ketQua.append("<tr>")
                          .append("<td>").append(cn.getMaCN()).append("</td>")
                          .append("<td>").append(cn.getHoTen()).append("</td>")
                          .append("<td>").append(cn.getGioiTinh()).append("</td>")
                          .append("<td>").append(cn.getSoGioLamVuot()).append("</td>")
                          .append("<td>").append(cn.tinhTienThuong()).append("</td>")
                          .append("</tr>");
                }
                ketQua.append("</table>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ketQua.append("<p>Lỗi hệ thống! Vui lòng thử lại sau.</p>");
        } finally {
            // Đóng tài nguyên
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // Gửi kết quả về JSP
        request.setAttribute("ketQua", ketQua.toString());
        request.getRequestDispatcher("TimKiemCN.jsp").forward(request, response);
    }
}
