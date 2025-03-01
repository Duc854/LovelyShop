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
public class adminReviewDeleting extends HttpServlet {
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
        String rIdToDel = request.getParameter("rIdToDel");
        //
        ReviewsDAO r = new ReviewsDAO();
        ProductDAO p = new ProductDAO();
        UserDAO u = new UserDAO();
        r.deleteReviews(rIdToDel);
        List<User> users = u.getAllUsers();
        List<Product> products = p.getAllProducts();
        List<Reviews> reviews = r.getAllReviews();
        List<Product> bestSeller = p.getBestSellerProduct();
        request.setAttribute("bestSeller", bestSeller);
        request.setAttribute("review", reviews);
        request.setAttribute("userList", users);
        request.setAttribute("productList", products);
        request.setAttribute("action", "review-management");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
