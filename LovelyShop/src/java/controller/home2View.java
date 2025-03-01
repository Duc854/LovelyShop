package controller;

import dal.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

public class home2View extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo mới session

        // Kiểm tra xem session có tồn tại và lấy userId
        if (session != null) {
            Integer userId = (Integer) session.getAttribute("userId"); 
            if (userId != null) {
                // Lấy danh sách sản phẩm và danh mục
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
                request.setAttribute("userId", userId); // Thêm userId vào thuộc tính

                // Chuyển hướng đến JSP
                request.getRequestDispatcher("Home2.jsp").forward(request, response);
            } else {
                // Nếu userId không tồn tại, có thể chuyển hướng về trang đăng nhập hoặc trang lỗi
                response.sendRedirect("login.jsp");
            }
        } else {
            // Nếu session không tồn tại, chuyển hướng về trang đăng nhập
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại, không tạo session mới nếu chưa tồn tại
        HttpSession session = request.getSession(false); 
        String userRole = (String )session.getAttribute("role");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if ("admin".equals(userRole)) {
            // Trả về JavaScript mở trang mới
        out.println("<script type='text/javascript'>");
        out.println("window.open('home2View', '_blank');"); // Mở 'home2View' trong tab mới
        out.println("window.location.href = 'admin.jsp';"); // Chuyển hướng tab hiện tại về 'admin.jsp'
        out.println("</script>");
        }
    }
}
