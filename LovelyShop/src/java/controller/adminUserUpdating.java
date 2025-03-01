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
public class adminUserUpdating extends HttpServlet {
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
        String uIdToUpdate = request.getParameter("uIdToUpdate");
        ProductDAO p = new ProductDAO();
        UserDAO u = new UserDAO();
        ReviewsDAO r = new ReviewsDAO();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("full_name");
        String phoneNum = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        User x = new User(username, password, email, fullName, phoneNum, address, role);
        u.updateInfor(uIdToUpdate, x);
        List<User> users = u.getAllUsers();
        List<Product> products = p.getAllProducts();
        List<Product> bestSeller = p.getBestSellerProduct();
        List<Reviews> reviews = r.getAllReviews();
        request.setAttribute("review", reviews);
        request.setAttribute("userList", users);
        request.setAttribute("productList", products);
        request.setAttribute("bestSeller", bestSeller);
        request.setAttribute("action", "user-show");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
