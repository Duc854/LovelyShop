/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

/**
 *
 * @author thanh
 */
public class subreviews extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewsDAO u = new ReviewsDAO();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Reviews review;

        String title = request.getParameter("review_title");
        String content = request.getParameter("reviewText");
        HttpSession session = request.getSession(false); // Không tạo mới session

        // Kiểm tra xem session có tồn tại và lấy userId
        if (session != null && session.getAttribute("role").equals("admin")) {
            int user_id = (Integer) session.getAttribute("userId");
            review = new Reviews(user_id, content, title);
            u.createReviews(review);
            List<Reviews> lst = u.getAllReviews();
            response.sendRedirect("admin.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewsDAO u = new ReviewsDAO();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Reviews review;

        String title = request.getParameter("review_title");
        String content = request.getParameter("reviewText");
        HttpSession session = request.getSession(false); // Không tạo mới session

        // Kiểm tra xem session có tồn tại và lấy userId
        if (session != null) {
            int user_id = (Integer) session.getAttribute("userId");
            review = new Reviews(user_id, content, title);
            u.createReviews(review);
            List<Reviews> lst = u.getAllReviews();
            request.setAttribute("review", lst);
            request.getRequestDispatcher("Review.jsp").forward(request, response);
        }
    }
}
