<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, Model.CongNhan, Model.KetNoi" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Công Nhân</title>
    <style>
         body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            padding: 20px;
        }
        .container {
            background: #fff;
            color: #333;
            padding: 20px;
            border-radius: 10px;
            max-width: 800px;
            margin: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #2575fc;
        }
        input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background: #2575fc;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background: #6a11cb;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: center;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    
    </style>

</head>
<body>
    <h1>Tìm Kiếm Công Nhân</h1>

    <!-- Form tìm kiếm -->
    <form action="TimKiemCN.jsp" method="post">
        <label for="hoTen">Nhập Tên Công Nhân:</label>
        <input type="text" id="hoTen" name="hoTen" required>
        <button type="submit">Tìm Kiếm</button>
    </form>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<CongNhan> danhSachCongNhan = new ArrayList<>();
        ArrayList<CongNhan> ketQuaTimKiem = new ArrayList<>();
        String hoTen = request.getParameter("hoTen");
        boolean timThay = false;

        try {
            conn = KetNoi.DataBase();
            String sql = "SELECT * FROM congnhan";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                CongNhan cn = new CongNhan(
                    rs.getInt("MaCN"),
                    rs.getString("HoTen"),
                    rs.getString("GioiTinh"),
                    rs.getInt("SoGioLamVuot")
                );
                danhSachCongNhan.add(cn);
            }
            if (hoTen != null && !hoTen.isEmpty()) {
                sql = "SELECT * FROM congnhan WHERE HoTen LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, "%" + hoTen + "%");
                rs = stmt.executeQuery();

                while (rs.next()) {
                    timThay = true;
                    CongNhan cn = new CongNhan(
                        rs.getInt("MaCN"),
                        rs.getString("HoTen"),
                        rs.getString("GioiTinh"),
                        rs.getInt("SoGioLamVuot")
                    );
                    ketQuaTimKiem.add(cn);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>

    <div class="message <%= (hoTen != null && timThay) ? "success" : "error" %>">
        <%
            if (hoTen != null) {
                if (timThay) {
                    out.print("Tìm thấy công nhân có tên: " + hoTen);
                } else {
                    out.print("Không tìm thấy công nhân nào có tên: " + hoTen);
                }
            }
        %>
    </div>

   <!-- Kết quả tìm kiếm -->
    <% if (request.getParameter("hoTen") != null) { %>
        <h3>Kết Quả Tìm Kiếm</h3>
        <table>
            <thead>
                <tr>
                    <th>Mã Công Nhân</th>
                    <th>Họ Tên</th>
                    <th>Giới Tính</th>
                    <th>Số Giờ Làm Vượt</th>
                    <th>Tiền Thưởng</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (!ketQuaTimKiem.isEmpty()) {
                        for (CongNhan cn : ketQuaTimKiem) {
                            int tienThuong = cn.getSoGioLamVuot() >= 40 ? 500000 : 
                                             (cn.getSoGioLamVuot() >= 30 ? 300000 : 200000);
                %>
                            <tr>
                                <td><%= cn.getMaCN() %></td>
                                <td><%= cn.getHoTen() %></td>
                                <td><%= cn.getGioiTinh() %></td>
                                <td><%= cn.getSoGioLamVuot() %></td>
                                <td><%= tienThuong %></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="5">Không có dữ liệu!</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <% } %>

    <!-- Danh sách toàn bộ công nhân -->
    <h3>Danh Sách Toàn Bộ Công Nhân</h3>
    <table>
        <thead>
            <tr>
                <th>Mã Công Nhân</th>
                <th>Họ Tên</th>
                <th>Giới Tính</th>
                <th>Số Giờ Làm Vượt</th>
                <th>Tiền Thưởng</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (!danhSachCongNhan.isEmpty()) {
                    for (CongNhan cn : danhSachCongNhan) {
                        int tienThuong = cn.getSoGioLamVuot() >= 40 ? 500000 : 
                                         (cn.getSoGioLamVuot() >= 30 ? 300000 : 200000);
            %>
                        <tr>
                            <td><%= cn.getMaCN() %></td>
                            <td><%= cn.getHoTen() %></td>
                            <td><%= cn.getGioiTinh() %></td>
                            <td><%= cn.getSoGioLamVuot() %></td>
                            <td><%= tienThuong %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="5">Không có dữ liệu!</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
