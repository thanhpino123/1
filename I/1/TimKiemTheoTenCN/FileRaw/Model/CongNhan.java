/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
public class CongNhan {
    private int maCN;
    private String hoTen;
    private String gioiTinh;
    private int soGioLamVuot;

    public CongNhan(int maCN, String hoTen, String gioiTinh, int soGioLamVuot) {
        this.maCN = maCN;
        this.hoTen = hoTen;
        this.gioiTinh = gioiTinh;
        this.soGioLamVuot = soGioLamVuot;
    }

    public int getMaCN() {
        return maCN;
    }

    public void setMaCN(int maCN) {
        this.maCN = maCN;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public int getSoGioLamVuot() {
        return soGioLamVuot;
    }

    public void setSoGioLamVuot(int soGioLamVuot) {
        this.soGioLamVuot = soGioLamVuot;
    }

    public int tinhTienThuong() {
        if (soGioLamVuot >= 40) return 500000;
        if (soGioLamVuot >= 30) return 300000;
        if (soGioLamVuot >= 20) return 200000;
        return 0;
    }
}
