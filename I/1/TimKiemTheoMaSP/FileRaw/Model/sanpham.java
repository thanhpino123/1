package Model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


public class sanpham {

    public sanpham(String maSanPham, String tenSP1, int soLuong1, double donGia1) {
    }
      private String maSP;
    private String tenSP;
    private int soLuong;
    private double donGia;

    

    // Getter và Setter cho mã sản phẩm
    public String getMaSP() {
        return maSP;
    }

    public void setMaSP(String maSP) {
        this.maSP = maSP;
    }

    // Getter và Setter cho tên sản phẩm
    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    // Getter và Setter cho số lượng
    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    // Getter và Setter cho đơn giá
    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
    }

    // Phương thức tính thành tiền
    public double tinhThanhTien() {
        return soLuong * donGia;
    }

    // Phương thức hiển thị thông tin sản phẩm
    @Override
    public String toString() {
        return "SanPham{" +
                "maSP='" + maSP + '\'' +
                ", tenSP='" + tenSP + '\'' +
                ", soLuong=" + soLuong +
                ", donGia=" + donGia +
                ", thanhTien=" + tinhThanhTien() +
                '}';
    }
    
    
}
