
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="model.NhanVien" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Nhân Viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 20px;
            color: #333;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
        }

        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            margin: 0 auto;
        }

        form input[type="text"],
        form input[type="number"],
        form select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        form button {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        form button:hover {
            background-color: #2980b9;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e0f7fa;
        }
        .message {
            text-align: center;
            margin: 10px auto;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            width: 80%;
        }
        .message.success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <h2>Thêm Nhân Viên</h2>
    <form action="XLThemNV" method="post">
        <label for="MaNV">Mã Nhân Viên:</label>
        <input type="text" name="MaNV" id="MaNV"  value="<%= request.getAttribute("MaNV") != null ? request.getAttribute("MaNV") : "" %>" required>

        <label for="HoTen">Họ Tên:</label>
        <input type="text" name="HoTen" id="HoTen" value="<%= request.getAttribute("HoTen") != null ? request.getAttribute("HoTen") : "" %>"  required>

        <label for="ChucVu">Chức Vụ:</label>
        <select name="ChucVu" id="ChucVu">
            <option value="Giam Doc" <%= "Giam Doc".equals(request.getAttribute("ChucVu")) ? "selected" : "" %>>Giám Đốc</option>
            <option value="Pho Giam Doc"<%= "Pho Giam Doc".equals(request.getAttribute("ChucVu")) ? "selected" : "" %>>Phó Giám Đốc</option>
            <option value="Truong Phong" <%= "Truong Phong".equals(request.getAttribute("ChucVu")) ? "selected" : "" %>>Trưởng Phòng</option>
            <option value="Nhan Vien"<%= "Nhan Vien".equals(request.getAttribute("ChucVu")) ? "selected" : "" %>>Nhân Viên</option>
        </select>

        <label for="HeSoLuong">Hệ Số Lương:</label>
        <input type="number" step="0.1" name="HeSoLuong" id="HeSoLuong"  value="<%= request.getAttribute("HeSoLuong") != null ? request.getAttribute("HeSoLuong") : "" %>"  required>

        <button type="submit">Thêm</button>
    </form>

    <hr>

    <h2 style="text-align: center;"> Danh Sách Nhân Viên</h2>
    <%
            // Hiển thị thông báo nhập thành công và nhập lỗi
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType");
        if (message != null && messageType != null) {
    %>
        <div class="message <%= messageType %>"><%= message %></div>
    <%
        }
    %>  
    
    <table>
        <tr>
            <th>Mã NV</th>
            <th>Họ Tên</th>
            <th>Chức Vụ</th>
            <th>Hệ Số Lương</th>
            <th>Phụ Cấp</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/qlnhanvien","root","");

                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM nhanvien");

                while (rs.next()) {
                    String chucVu = rs.getString("ChucVu");
                    double phuCap = 0;
                    switch (chucVu) {
                        case "Giam Doc": phuCap = 10000000; break;
                        case "Pho Giam Doc": phuCap = 7000000; break;
                        case "Truong Phong": phuCap = 5000000; break;
                        case "Nhan Vien": phuCap = 1000000; break;
                    }
        %>
        <tr>
            <td><%= rs.getString("MaNV") %></td>
            <td><%= rs.getString("HoTen") %></td>
            <td><%= rs.getString("ChucVu") %></td>
            <td><%= rs.getFloat("HeSoLuong") %></td>
            <td><%= phuCap %></td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>