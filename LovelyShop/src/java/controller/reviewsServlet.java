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
public class reviewsServlet extends HttpServlet {

     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          HttpSession session = request.getSession(false);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        ReviewsDAO u = new ReviewsDAO();
        List<Reviews> lst = u.getAllReviews();
       if(lst==null)  request.getRequestDispatcher("Home1.jsp").forward(request, response);
        request.setAttribute("review",lst);
        request.getRequestDispatcher("Review.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewsDAO u = new ReviewsDAO();
        UserDAO tmp= new UserDAO();
           response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
       Reviews review;
      
      List<Reviews> lst = u.getAllReviews();  
      request.setAttribute("review",lst);
        
        int review_id=Integer.parseInt(request.getParameter("review_id"));
        review=u.getReviewById(review_id);
        if(review_id==0) request.getRequestDispatcher("Home1.jsp").forward(request, response);
        User x=new User();
        x=tmp.searchByID(review.getUser_id());
        request.setAttribute("detail", review);
        request.setAttribute("User_name", x.getFullName());
         request.getRequestDispatcher("detailReview.jsp").forward(request, response);
    }
}
 
    