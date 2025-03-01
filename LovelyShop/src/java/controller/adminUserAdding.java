package controller;

import dal.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

/**
 *
 * @author ADMIN
 */
public class adminUserAdding extends HttpServlet {
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO p = new ProductDAO();
        UserDAO u = new UserDAO();
        ReviewsDAO r = new ReviewsDAO();
        CategoryDAO c = new CategoryDAO();
        List<Category> categories = c.getAllCategories();
        List<User> users = u.getAllUsers();
        List<Product> products = p.getAllProducts();
        List<Product> bestSeller = p.getBestSellerProduct();
        List<Reviews> reviews = r.getAllReviews();
        request.setAttribute("categoryList", categories);
        request.setAttribute("review", reviews);
        request.setAttribute("userList", users);
        request.setAttribute("productList", products);
        request.setAttribute("bestSeller", bestSeller);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //
        ReviewsDAO r = new ReviewsDAO();
        ProductDAO p = new ProductDAO();
        UserDAO u = new UserDAO();
        List<User> users = u.getAllUsers();
        List<Product> products = p.getAllProducts();
        List<Reviews> reviews = r.getAllReviews();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("full_name");
        String phoneNum = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Kiểm tra tên đăng nhập và email có tồn tại không
        for (User userValid : users) {
            if (username.equals(userValid.getUsername())) {
                request.setAttribute("message", "Username already exists!!! Please use another username");
                request.setAttribute("action", "user-add");
                List<Product> bestSeller = p.getBestSellerProduct();
                request.setAttribute("review", reviews);
                request.setAttribute("userList", users);
                request.setAttribute("productList", products);
                request.setAttribute("bestSeller", bestSeller);
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                return;
            }
            if (email.equals(userValid.getEmail())) {
                request.setAttribute("message", "Email has been registered!!! Please use another email");
                request.setAttribute("action", "user-add");
                List<Product> bestSeller = p.getBestSellerProduct();
                request.setAttribute("review", reviews);
                request.setAttribute("userList", users);
                request.setAttribute("productList", products);
                request.setAttribute("bestSeller", bestSeller);
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                return;
            }
        }

        // Nếu không có vấn đề gì, tạo người dùng mới
        User user = new User(username, password, email, fullName, phoneNum, address, role);
        u.createUser(user);
        request.setAttribute("message", "Account has been successfully registered!");
        request.setAttribute("action", "user-add");
        List<User> uList = u.getAllUsers();
        List<Product> bestSeller = p.getBestSellerProduct();
        request.setAttribute("review", reviews);
        request.setAttribute("userList", uList);
        request.setAttribute("productList", products);
        request.setAttribute("bestSeller", bestSeller);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
