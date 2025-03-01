package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class NavigationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();

        // Kiểm tra nếu URL là /home1.jsp
        if (requestURI.endsWith("/Home1.jsp")) {
            // Chuyển hướng đến /homeView
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/homeView");
        } else if (requestURI.endsWith("/Home2.jsp")) {
            // Chuyển hướng đến /homeView
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home2View");
        } else if (requestURI.contains("/admin")) {
            // Chuyển hướng đến /homeView
            String role = (String) session.getAttribute("role");
            if (role.equals("admin")) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/adminServlet");
            } else {
        // Xóa dữ liệu 'userId' trong session
        session.removeAttribute("userId");
        session.removeAttribute("role");
        // Hủy session
        session.invalidate();
                httpResponse.sendRedirect("login.jsp?error=error_admin_access");
            }
        } else if (requestURI.endsWith("/product.jsp")) {
            // Chuyển hướng đến /homeView
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/productView");
        } else if (requestURI.endsWith("/Review.jsp")) {
            // Chuyển hướng đến /homeView
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/reviews");
        } else if (requestURI.endsWith("/detailReview.jsp")) {
            // Chuyển hướng đến /homeView
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/reviews");
        } else {
            // Tiếp tục xử lý các request khác
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Giải phóng tài nguyên nếu cần
    }
}
