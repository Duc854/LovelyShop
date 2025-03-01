package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter (nếu cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Lấy session
        HttpSession session = httpRequest.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);
        String requestURI = httpRequest.getRequestURI();

        // Nếu người dùng chưa đăng nhập và không truy cập home1.jsp, chuyển hướng đến trang đăng nhập
        if (!loggedIn && !requestURI.endsWith("home1.jsp") && !requestURI.endsWith("homeView")) {
            httpResponse.sendRedirect("login.jsp?error=not_logged_in");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Giải phóng tài nguyên (nếu cần)
    }
}
