/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.*;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class UserDAO extends MyDAO {

    public void createUser(User x) {
        xSql = "insert into Users (username, password, email, full_name, phone_number, address) values (?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getUsername());
            ps.setString(2, x.getPassword());
            ps.setString(3, x.getEmail());
            ps.setString(4, x.getFullName());
            ps.setString(5, x.getPhoneNum());
            ps.setString(6, x.getAddress());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String xUser_id) {
        xSql = "delete from Users where user_id=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, xUser_id);
            ps.executeUpdate();
            //con.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateInfor(String xUser_id, User x) {
        xSql = "UPDATE Users SET username = ?,   password = ?,  email = ?,  full_name = ?,  phone_number = ?,  address = ?, role = ? WHERE user_id = ?;";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getUsername());
            ps.setString(2, x.getPassword());
            ps.setString(3, x.getEmail());
            ps.setString(4, x.getFullName());
            ps.setString(5, x.getPhoneNum());
            ps.setString(6, x.getAddress());
            ps.setString(7, x.getRole());
            ps.setString(8, xUser_id);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
     public void updateUserInfor(int xUser_id, User x) {
        xSql = "UPDATE Users SET  email = ?,  full_name = ?,  phone_number = ?,  address = ? WHERE user_id = ?;";
        try {
            ps = con.prepareStatement(xSql);
           
            ps.setString(1, x.getEmail());
            ps.setString(2, x.getFullName());
            ps.setString(3, x.getPhoneNum());
            ps.setString(4, x.getAddress());    
            ps.setString(5, Integer.toString(xUser_id));
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

 public List<User> getAllUsers() {
    List<User> x = new ArrayList<>();
    xSql = "select * from Users order by user_id asc";
    try {
        ps = con.prepareStatement(xSql);
        rs = ps.executeQuery();
        int userId;
        String username, password, email, fullName, phoneNumber, address, role;
        Date createdAt;
        User user;
        while (rs.next()) {
            userId = rs.getInt("user_id");
            username = rs.getString("username");
            password = rs.getString("password");
            email = rs.getString("email");
            fullName = rs.getString("full_name");
            phoneNumber = rs.getString("phone_number");
            address = rs.getString("address");
            role = rs.getString("role");
            createdAt = new Date(rs.getTimestamp("created_at").getTime());
            user = new User(userId, username, password, email, fullName, phoneNumber, address,role, createdAt); // Sử dụng constructor có role
            x.add(user);
        }
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return x;
}

    public List<User> searchByName(String name) {
        List<User> users = new ArrayList<>();
        xSql = "SELECT * FROM Users WHERE full_name LIKE ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + name + "%"); // Sử dụng LIKE để tìm kiếm tên tương tự
            rs = ps.executeQuery();

            int userId;
            String username, password, email, fullName, phoneNumber, address, role;
            Date createdAt;
            User user;

            while (rs.next()) {
                userId = rs.getInt("user_id");
                username = rs.getString("username");
                password = rs.getString("password");
                email = rs.getString("email");
                fullName = rs.getString("full_name");
                phoneNumber = rs.getString("phone_number");
                address = rs.getString("address");
                role = rs.getString("role");
                createdAt = new Date(rs.getTimestamp("created_at").getTime());

                // Tạo đối tượng User và thêm vào danh sách kết quả
                user = new User(userId, username, password, email, fullName, phoneNumber, address, role, createdAt);
                users.add(user);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
    public User searchByID(int ID) {
       
        xSql = "SELECT * FROM Users WHERE user_id LIKE ?";
  User user = null;
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, ID ); // Sử dụng LIKE để tìm kiếm tên tương tự
            rs = ps.executeQuery();

            int userId;
            String username, password, email, fullName, phoneNumber, address, role;
            Date createdAt;
          

            while (rs.next()) {
                userId = rs.getInt("user_id");
                username = rs.getString("username");
                password = rs.getString("password");
                email = rs.getString("email");
                fullName = rs.getString("full_name");
                phoneNumber = rs.getString("phone_number");
                address = rs.getString("address");
                role = rs.getString("role");
                createdAt = new Date(rs.getTimestamp("created_at").getTime());

                // Tạo đối tượng User và thêm vào danh sách kết quả
                user = new User(userId, username, password, email, fullName, phoneNumber, address, role, createdAt);
              
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
