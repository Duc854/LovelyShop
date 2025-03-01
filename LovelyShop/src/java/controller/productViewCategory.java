package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;

public class productViewCategory extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");

        // Lấy danh sách sản phẩm và danh mục từ database
        ProductDAO p = new ProductDAO();
        CategoryDAO c = new CategoryDAO();
        List<Category> categories = c.getAllCategories();
        List<Product> products = p.getHomeProducts();

    // Lưu dữ liệu vào session
    HttpSession session = request.getSession();
        session.setAttribute("categories", categories);
        session.setAttribute("products", products);
        session.setAttribute("selectedCategoryId", categoryId); // Lưu ID của danh mục đã chọn

        // Chuyển hướng đến trang sản phẩm
    String redirectUrl = "product.jsp";
    if (categoryId != null && !categoryId.isEmpty()) {
        redirectUrl += "#category-" + categoryId; // Thêm anchor vào URL
    }
    response.sendRedirect(redirectUrl);
    }
}
