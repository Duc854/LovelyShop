/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author ADMIN
 */
public class ShoppingCartDAO extends MyDAO {

    public List<ShoppingCart> getCartAdmin(String keyword) {
        xSql = "SELECT * FROM Shopping_Cart JOIN Products ON Shopping_Cart.product_id = Products.product_id WHERE Shopping_Cart.cart_id = ?";
        List<ShoppingCart> scList = new ArrayList<>();
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, keyword);
            rs = ps.executeQuery();
            int cartId;
            int productId;
            int quantity;
            String productName;
            double price;
            double total;
            String status;
            while (rs.next()) {
                cartId = rs.getInt("cart_id");
                productId = rs.getInt("product_id");
                quantity = rs.getInt("quantity");
                productName = rs.getString("product_name");
                price = rs.getDouble("price");
                total = quantity * price;
                status = rs.getString("status");
                ShoppingCart sc = new ShoppingCart(cartId, productId, quantity, productName, price, total, status);
                scList.add(sc);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scList;
    }

    public void deleteCartById(String cartId) {
        xSql = "delete from Shopping_Cart where cart_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, cartId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ShoppingCart> getCartByUserId(int userId) {
        List<ShoppingCart> cartItems = new ArrayList<>();
        xSql = "SELECT sc.cart_id, sc.product_id, sc.quantity, sc.status, "
                + "p.product_name, p.price "
                + "FROM Shopping_Cart sc "
                + "JOIN Products p ON sc.product_id = p.product_id "
                + "WHERE sc.cart_id = ? AND sc.status = 'unpaid'";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int cartId = rs.getInt("cart_id");
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                String status = rs.getString("status");
                String productName = rs.getString("product_name");
                double price = rs.getDouble("price");

                double total = price * quantity;

                // Tạo đối tượng ShoppingCart và thêm vào danh sách
                ShoppingCart cartItem = new ShoppingCart(cartId, productId, quantity, productName, price, total, status);
                cartItems.add(cartItem);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    public void updateAddQuantity(int cartId, int productId, int newQuantity) {
        xSql = "UPDATE Shopping_Cart SET quantity = ? WHERE cart_id = ? AND product_id = ? AND status = 'unpaid'";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);

            ps.executeUpdate();

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertAddCart(int userId, int productId, int quantity) {
        xSql = "SELECT quantity FROM Shopping_Cart WHERE cart_id = ? AND product_id = ? AND status = 'unpaid'";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu sản phẩm đã tồn tại với trạng thái 'unpaid', cập nhật số lượng
                int currentQuantity = rs.getInt("quantity");
                String updateSql = "UPDATE Shopping_Cart SET quantity = ? WHERE cart_id = ? AND product_id = ? AND status = 'unpaid'";
                ps = con.prepareStatement(updateSql);
                ps.setInt(1, currentQuantity + quantity); // Cộng thêm số lượng mới
                ps.setInt(2, userId);
                ps.setInt(3, productId);
                ps.executeUpdate();
            } else {
                // Nếu chưa tồn tại, thêm mới sản phẩm với trạng thái 'unpaid'
                String insertSql = "INSERT INTO Shopping_Cart (cart_id, product_id, quantity, status) VALUES (?, ?, ?, 'unpaid')";
                ps = con.prepareStatement(insertSql);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                ps.close();
            } catch (Exception ignored) {
            }
        }
    }

    public void updateCartStatusToPaidByUserId(int userId, int productId) {
        xSql = "UPDATE Shopping_Cart SET status = 'paid' WHERE cart_id = ? AND product_id = ? AND status = 'unpaid'";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId); // Sử dụng userId ở đây
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                ps.close();
            } catch (Exception ignored) {
            }
        }
    }

    public boolean checkIfProductExistsPaid(int userId, int productId) {
        xSql = "SELECT COUNT(*) FROM Shopping_Cart WHERE cart_id = ? AND product_id = ? AND status = 'paid'";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if a paid record exists
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                ps.close();
            } catch (Exception ignored) {
            }
        }
        return false; // No paid record found
    }

    public void insertPaidProduct(int userId, ShoppingCart item) {
        xSql = "INSERT INTO Shopping_Cart (cart_id, product_id, quantity, status) VALUES (?, ?, ?, 'paid')";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                ps.close();
            } catch (Exception ignored) {
            }
        }
    }

    public void updateQuantityForPaidProduct(int userId, int productId, int additionalQuantity) {
        xSql = "SELECT quantity FROM Shopping_Cart WHERE cart_id = ? AND product_id = ? AND status = 'paid'";

        try {
            // Prepare and execute the select query
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // If the product exists with status 'paid', get the current quantity
                int currentQuantity = rs.getInt("quantity");

                // Update the quantity with the new total for the paid status
                String updateSql = "UPDATE Shopping_Cart SET quantity = ? WHERE cart_id = ? AND product_id = ? AND status = 'paid'";
                ps = con.prepareStatement(updateSql);
                ps.setInt(1, currentQuantity + additionalQuantity); // Add the additional quantity
                ps.setInt(2, userId);
                ps.setInt(3, productId);
                ps.executeUpdate();
            } else {
                // If no 'paid' record exists, insert a new paid record
                String insertSql = "INSERT INTO Shopping_Cart (cart_id, product_id, quantity, status) VALUES (?, ?, ?, 'paid')";
                ps = con.prepareStatement(insertSql);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.setInt(3, additionalQuantity); // Set the initial quantity
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ignored) {
            }
        }
    }

    public void deleteUnpaidProduct(int userId, int productId) {
        String xSql = "DELETE FROM Shopping_Cart WHERE cart_id = ? AND product_id = ? AND status = 'unpaid'";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                ps.close();
            } catch (Exception ignored) {
            }
        }
    }

    public void clearCartByUserId(int userId) {
        xSql = "DELETE FROM Shopping_Cart WHERE cart_id = ?"; // Cần thay đổi dòng này
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId); // Đảm bảo rằng cart_id đúng với userId
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
