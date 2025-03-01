package controller;

import dal.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

public class homeView extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO p = new ProductDAO();
        CategoryDAO c = new CategoryDAO();
        ReviewsDAO u = new ReviewsDAO();
        List<Category> categories = c.getAllCategories();
        List<Product> products = p.getHomeProducts();
        List<Reviews> lst = u.getHomeReviews();
        // Chuyển các thuộc tính đến JSP        
        request.setAttribute("review", lst);
        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);
        request.getRequestDispatcher("Home1.jsp").forward(request, response);
    }
}
