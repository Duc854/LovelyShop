package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;


public class productView extends HttpServlet {

     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Khởi tạo DAO
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy danh sách categories và products
        List<Category> categories = categoryDAO.getAllCategories();
        List<Product> products = productDAO.getAllProducts();

        // Lưu dữ liệu vào session
        HttpSession session = request.getSession();
        session.setAttribute("categories", categories);
        session.setAttribute("products", products);

        // Chuyển hướng đến product.jsp
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }

}
