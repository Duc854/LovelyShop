/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class ShoppingCart {
    private int userId;
    private int productId;
    private String srcImg;
    private int quantity;
    private String productName;
    private double price;
    private double total;
    private String status;

    public ShoppingCart(int userId, int productId,String srcImg, int quantity, String productName, double price, String status) {
        this.userId = userId;
        this.productId = productId;
        this.srcImg = srcImg;
        this.quantity = quantity;
        this.productName = productName;
        this.price = price;
        this.total = price*quantity;
        this.status = status;
    }

    public ShoppingCart(int userId, int productId, int quantity, String productName, double price, double total, String status) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.productName = productName;
        this.price = price;
        this.total = total;
        this.status = status;
    }

    public ShoppingCart() {
    }

    public String getSrcImg() {
        return srcImg;
    }

    public void setSrcImg(String srcImg) {
        this.srcImg = srcImg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    
}
