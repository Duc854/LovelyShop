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
public class adminProductSearchByName extends HttpServlet {
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
        String productSearchByName = request.getParameter("xProductSearch");
        ProductDAO p = new ProductDAO();
        UserDAO u = new UserDAO();
        ReviewsDAO r = new ReviewsDAO();
        ShoppingCartDAO sc = new ShoppingCartDAO();
        List<Product> xProductSearch = p.searchProductsByName(productSearchByName);
        List<User> users = u.getAllUsers();
        List<Product> products = p.getAllProducts();
        List<Product> bestSeller = p.getBestSellerProduct();
        List<Reviews> reviews = r.getAllReviews();
        request.setAttribute("xProductSearch", xProductSearch);
        request.setAttribute("review", reviews);
        request.setAttribute("userList", users);
        request.setAttribute("productList", products);
        request.setAttribute("bestSeller", bestSeller);
        request.setAttribute("action", "product-show");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
