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
public class CategoryDAO extends MyDAO {
  
    // Lấy tất cả các category từ database
public List<Category> getAllCategories() {
    List<Category> categories = new ArrayList<>();
    xSql = "SELECT * FROM Categories ORDER BY category_id ASC";    
    try {
        ps = con.prepareStatement(xSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            int categoryId = rs.getInt("category_id");
            String categoryName = rs.getString("category_name");
            String description = rs.getString("description");
            String sourceImg = rs.getString("category_img");
            Category category = new Category(categoryId, categoryName, description, sourceImg);
            categories.add(category);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } 
    return categories;
}


    // Thêm mới category vào database
    public void insertCategory(Category category) {
        xSql = "INSERT INTO Categories (category_name, description) VALUES (?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin category theo ID
    public void updateCategory(Category category) {
        xSql = "UPDATE Categories SET category_name = ?, description = ? WHERE category_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa category theo ID
    public void deleteCategory(int categoryId) {
        xSql = "DELETE FROM Categories WHERE category_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Tìm category theo ID
    public Category getCategoryById(int categoryId) {
        Category category = null;
        xSql = "SELECT * FROM Categories WHERE category_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String categoryName = rs.getString("category_name");
                String description = rs.getString("description");
                String sourceImg = rs.getString("category_img");
                category = new Category(categoryId, categoryName, description,sourceImg );
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }
}
