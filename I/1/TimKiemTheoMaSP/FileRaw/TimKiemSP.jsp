
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.sanpham" %> 

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <style>
            body {
    font-family: Arial, sans-serif; 
    background-color: #f2f2f2;
    color: #333;
    text-align: center;
}

h1 {
    color: #4CAF50;
}

form {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 0px 10px 0px #aaaaaa;
    display: inline-block;
    margin-top: 50px;
}

label {
    font-weight: bold;
    color: #333;
}

input[type="text"] {
    padding: 8px;
    width: 200px;
    margin: 10px 0;
    border-radius: 4px;
    border: 1px solid #ccc;
}

button {
    padding: 10px 20px;
    background-color: #4CAF50;
    color: #ffffff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}

table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
}

th, td {
    padding: 12px;
    text-align: center;
    border: 1px solid #ddd;
}

th {
    background-color: #4CAF50;
    color: white;
}
        </style>
        
        <h1>Tìm kiếm sản phẩm</h1>
    <form action="TimKiemSP.jsp" method="post">
        <label for="maSP">Mã sản phẩm:</label>
        <input type="text" id="maSP" name="maSP" required>
        <button type="submit">Tìm kiếm</button>
    </form>

    <h2>Danh sách sản phẩm hiện có</h2>
    <table>
        

        <%
        // Lấy mã sản phẩm từ yêu cầu POST (nếu có)
        String maSPTimKiem = request.getParameter("maSP");
        if (maSPTimKiem != null && !maSPTimKiem.isEmpty()) {
            try {
                // Kết nối cơ sở dữ liệu
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/qlsanpham","root","");

                // Truy vấn sản phẩm theo mã
                String sql = "SELECT MaSP, TenSP, SoLuong, DonGia, (SoLuong * DonGia) AS ThanhTien FROM sanpham WHERE MaSP = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, maSPTimKiem);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Nếu tìm thấy sản phẩm, hiển thị thông tin sản phẩm
    %>
                    <table>
                        <tr>
                            <th>Mã SP</th>
                            <th>Tên SP</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                        <tr>
                            <td><%= rs.getString("MaSP") %></td>
                            <td><%= rs.getString("TenSP") %></td>
                            <td><%= rs.getInt("SoLuong") %></td>
                            <td><%= rs.getDouble("DonGia") %></td>
                            <td><%= rs.getDouble("ThanhTien") %></td>
                        </tr>
                    </table>
    <%
                } else {
                    // Nếu không tìm thấy, hiển thị thông báo
                    out.println("<p>Không tìm thấy mã sản phẩm.</p>");
                }

                // Đóng kết nối
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>

    <h2>Danh sách sản phẩm hiện có</h2>

    <table>
        <tr>
            <th>Mã SP</th>
            <th>Tên SP</th>
            <th>Số Lượng</th>
            <th>Đơn Giá</th>
            <th>Thành Tiền</th>
        </tr>

        <% 
            try {
                // Kết nối cơ sở dữ liệu
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/qlsanpham","root","");

                // Truy vấn tất cả sản phẩm
                String sql = "SELECT MaSP, TenSP, SoLuong, DonGia, (SoLuong * DonGia) AS ThanhTien FROM sanpham";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                // Duyệt kết quả và hiển thị trong bảng
                while (rs.next()) {
                    String maSP = rs.getString("MaSP");
                    String tenSP = rs.getString("TenSP");
                    int soLuong = rs.getInt("SoLuong");
                    double donGia = rs.getDouble("DonGia");
                    double thanhTien = rs.getDouble("ThanhTien");
        %>
                    <tr>
                        <td><%= maSP %></td>
                        <td><%= tenSP %></td>
                        <td><%= soLuong %></td>
                        <td><%= donGia %></td>
                        <td><%= thanhTien %></td>
                    </tr>
        <%
                }
                // Đóng kết nối
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
    </body>
</html>
