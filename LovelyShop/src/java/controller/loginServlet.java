/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.MyDAO;
import dal.ProductDAO;
import dal.ShoppingCartDAO;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.Category;
import model.Product;
import model.ShoppingCart;

/**
 *
 * @author ADMIN
 */
public class loginServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(false);

    if (session != null) {
        // Xóa dữ liệu 'userId' trong session
        session.removeAttribute("userId");
        session.removeAttribute("role");
        // Hủy session
        session.invalidate();
    }

    // Điều hướng về trang login hoặc trang nào đó sau khi xóa session
    response.sendRedirect("login.jsp"); 
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("userId");
        session.removeAttribute("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        ProductDAO p = new ProductDAO();
        CategoryDAO c = new CategoryDAO();
        List<Category> categories = c.getAllCategories();
        List<Product> products = p.getHomeProducts();

        // Khởi tạo MyDAO
        MyDAO myDAO = new MyDAO();

        try {
            // Thực hiện truy vấn để lấy vai trò của người dùng
            String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
            myDAO.ps = myDAO.con.prepareStatement(sql);
            myDAO.ps.setString(1, username);
            myDAO.ps.setString(2, password);
            myDAO.rs = myDAO.ps.executeQuery();

            if (myDAO.rs.next()) {
                // Đăng nhập thành công
                String role = myDAO.rs.getString("role");
                int userId = myDAO.rs.getInt("user_id");

                // Lưu thông tin vào session
                session.setAttribute("role",role);
                session.setAttribute("userId", userId); // Lưu userId vào session
                ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
                List<ShoppingCart> cart = (ArrayList<ShoppingCart>) session.getAttribute("cart");
                if (cart == null) {
                    cart = shoppingCartDAO.getCartByUserId(userId);
                    if (cart == null) {
                        cart = new ArrayList<>();
                    }
                }
                session.setAttribute("cart", cart);
                if ("admin".equals(role)) {
                    // Chuyển hướng đến servlet quản lý admin
                    response.sendRedirect("adminServlet");
                } else if ("customer".equals(role)) {
                    // Chuyển hướng đến servlet cho khách hàng
                    response.sendRedirect("home2View");
                }
            } else {
                // Đăng nhập thất bại
                request.setAttribute("errorMessage", "Username or password is not correct!!!Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong! Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // Đóng kết nối
            try {
                if (myDAO.rs != null) {
                    myDAO.rs.close();
                }
                if (myDAO.ps != null) {
                    myDAO.ps.close();
                }
                myDAO.finalize(); // Đảm bảo kết nối được đóng
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
