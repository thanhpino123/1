/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package model;

import model.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


@WebServlet(name="XLThemNV", urlPatterns={"/XLThemNV"})
public class XLThemNV extends HttpServlet {
  
    //Sua Ca Ten File
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet XLThemNV</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet XLThemNV at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        String maNV = request.getParameter("MaNV");
        String hoTen = request.getParameter("HoTen");
        String chucVu = request.getParameter("ChucVu");
        float heSoLuong = Float.parseFloat(request.getParameter("HeSoLuong"));
         // Lưu dữ liệu nhập vào request
        request.setAttribute("MaNV", maNV);
        request.setAttribute("HoTen", hoTen);
        request.setAttribute("ChucVu", chucVu);
        request.setAttribute("HeSoLuong", heSoLuong);

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/qlnhanvien","root","");

            // Kiểm tra mã nhân viên có trùng không
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM nhanvien WHERE MaNV = ?");
            checkStmt.setString(1, maNV);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("message", "Thêm không thành công do trùng mã nhân viên: " + maNV);
                 request.setAttribute("messageType", "error"); // Lỗi (màu đỏ)
            } else {
                // Thêm nhân viên mới
                PreparedStatement insertStmt = conn.prepareStatement(
                        "INSERT INTO nhanvien (MaNV, HoTen, ChucVu, HeSoLuong) VALUES (?, ?, ?, ?)");
                insertStmt.setString(1, maNV);
                insertStmt.setString(2, hoTen);
                insertStmt.setString(3, chucVu);
                insertStmt.setFloat(4, heSoLuong);
                insertStmt.executeUpdate();

                request.setAttribute("message", "Thêm thành công mã nhân viên: " + maNV);
                 request.setAttribute("messageType", "success"); // Thành công (màu xanh)
            }

            // Đọc dữ liệu từ bảng NhanVien và lưu vào ArrayList
            PreparedStatement selectStmt = conn.prepareStatement("SELECT * FROM nhanvien");
            ResultSet resultSet = selectStmt.executeQuery();
            ArrayList<NhanVien> danhSachNhanVien = new ArrayList<>();

            while (resultSet.next()) {
                NhanVien nv = new NhanVien();
                nv.setMaNV(resultSet.getString("MaNV"));
                nv.setHoTen(resultSet.getString("HoTen"));
                nv.setChucVu(resultSet.getString("ChucVu"));
                nv.setHeSoLuong(resultSet.getFloat("HeSoLuong"));
                danhSachNhanVien.add(nv);
            }

            // Gửi danh sách nhân viên và thông báo về JSP
            request.setAttribute("danhSachNhanVien", danhSachNhanVien);
            RequestDispatcher dispatcher = request.getRequestDispatcher("ThemNV.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
        
        
        
       
    }

  

