/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.*;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class ProductDAO extends MyDAO {
    
    public List<Product> searchProductsByName(String productName) {
    List<Product> products = new ArrayList<>();
    xSql = "SELECT * FROM Products WHERE product_name LIKE ?";
    
    try {
        ps = con.prepareStatement(xSql);
        ps.setString(1, "%" + productName + "%");
        rs = ps.executeQuery();

        while (rs.next()) {
            int productId = rs.getInt("product_id");
            String name = rs.getString("product_name");
            String description = rs.getString("description");
            double price = rs.getDouble("price");
            int stockQuantity = rs.getInt("stock_quantity");
            int categoryId = rs.getInt("category_id");
            Timestamp createdAt = rs.getTimestamp("created_at");
            String sourceImg = rs.getString("source_img");

            Product product = new Product(productId, name, description, price, stockQuantity, categoryId, createdAt, sourceImg);
            products.add(product);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } 
    return products;
}

    public void createProduct(Product p) {
        String xSql = "INSERT INTO Products (product_name, description, price, stock_quantity, category_id, sourceImg) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setInt(5, p.getCategoryId());
            ps.setString(6, p.getSourceImg());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String productId) {
        xSql = "DELETE FROM Products WHERE product_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, productId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(String productId, Product p) {
        xSql = "UPDATE Products SET product_name = ?, description = ?, price = ?, stock_quantity = ?, category_id = ?, sourceImg = ? WHERE product_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setInt(5, p.getCategoryId());
            ps.setString(6, p.getSourceImg());
            ps.setString(7, productId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void increaseQuantityProduct(String productId, Product p) {
        xSql = "UPDATE Products SET stock_quantity = ? WHERE product_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            int quantity = p.getStockQuantity() + 1;  // Tăng số lượng sản phẩm
            ps.setInt(1, quantity);
            ps.setString(2, productId);
            ps.executeUpdate();
            ps.close();
            p.setStockQuantity(quantity);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reduceQuantity(String productId, Product p) {
        xSql = "UPDATE Products SET stock_quantity = ? WHERE product_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            int quantity = p.getStockQuantity() - 1;  // Tăng số lượng sản phẩm
            ps.setInt(1, quantity);
            ps.setString(2, productId);
            ps.executeUpdate();
            ps.close();
            p.setStockQuantity(quantity);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        xSql = "SELECT * FROM Products";
        Product product;
        int productId;
        String productName;
        String description;
        double price;
        int stockQuantity;
        int categoryId;
        Date createdAt;
        String sourceImg;
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                productId = rs.getInt("product_id");
                productName = rs.getString("product_name");
                description = rs.getString("description");
                price = rs.getDouble("price");
                stockQuantity = rs.getInt("stock_quantity");
                categoryId = rs.getInt("category_id");
                createdAt = new Date(rs.getTimestamp("created_at").getTime());
                sourceImg = rs.getString("sourceImg");
                // Tạo đối tượng Product và thêm vào danh sách
                product = new Product(productId, productName, description, price,
                        stockQuantity, categoryId, createdAt, sourceImg);
                productList.add(product);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public Product getProductById(String Id) {
        Product x = new Product();
        xSql = "SELECT * FROM Products WHERE product_id = ?";
        int productId;
        String productName;
        String description;
        double price;
        int stockQuantity;
        int categoryId;
        Date createdAt;
        String sourceImg;
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, Id);
            rs = ps.executeQuery();
            while (rs.next()) {
                productId = rs.getInt("product_id");
                productName = rs.getString("product_name");
                description = rs.getString("description");
                price = rs.getDouble("price");
                stockQuantity = rs.getInt("stock_quantity");
                categoryId = rs.getInt("category_id");
                createdAt = new Date(rs.getTimestamp("created_at").getTime());
                sourceImg = rs.getString("sourceImg");
                x = new Product(productId, productName, description, price, stockQuantity, categoryId, createdAt, sourceImg);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return x;
    }

    public List<Product> getHomeProducts() {
        List<Product> productList = new ArrayList<>();
        xSql = "SELECT TOP 8 * FROM Products Order by created_at DESC";
        Product product;
        int productId;
        String productName;
        String description;
        double price;
        int stockQuantity;
        int categoryId;
        Date createdAt;
        String sourceImg;
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                productId = rs.getInt("product_id");
                productName = rs.getString("product_name");
                description = rs.getString("description");
                price = rs.getDouble("price");
                stockQuantity = rs.getInt("stock_quantity");
                categoryId = rs.getInt("category_id");
                createdAt = new Date(rs.getTimestamp("created_at").getTime());
                sourceImg = rs.getString("sourceImg");
                // Tạo đối tượng Product và thêm vào danh sách
                product = new Product(productId, productName, description, price, stockQuantity, categoryId, createdAt, sourceImg);
                productList.add(product);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> getBestSellerProduct() {
        List<Product> bestSeller = new ArrayList<>();
        xSql = "SELECT TOP 10 s.product_id, p.product_name, SUM(s.quantity) AS total_quantity_sold, p.price FROM Shopping_Cart s "
                + "JOIN Products p ON s.product_id = p.product_id WHERE s.status = 'paid'"
                + "GROUP BY s.product_id, p.product_name, p.price ORDER BY total_quantity_sold DESC";

        String productName;
        int quantity, productId;
        double price, totalPrice;

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                productId = rs.getInt("product_id");
                productName = rs.getString("product_name");
                price = rs.getDouble("price");  // Giá của một sản phẩm
                quantity = rs.getInt("total_quantity_sold");  // Tổng số lượng đã bán

                // Tính tổng doanh thu từ sản phẩm
                totalPrice = price * quantity;

                // Tạo đối tượng Product và thêm vào danh sách
                Product product = new Product(productId, productName, totalPrice, quantity);
                bestSeller.add(product);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bestSeller;
    }

    public void updateStockAfterPayment(List<ShoppingCart> cartItems) {
        xSql = "UPDATE Products SET stock_quantity = stock_quantity - ? WHERE product_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            for (ShoppingCart cartItem : cartItems) {
                ps.setInt(1, cartItem.getQuantity()); // Subtract the ordered quantity
                ps.setInt(2, cartItem.getProductId()); // Update based on product ID
                ps.executeUpdate();
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
