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

public class UserInfo extends HttpServlet {


  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession(false); // Không tạo mới session
         UserDAO u=new UserDAO();
    // Kiểm tra xem session có tồn tại và lấy userId
    int userID;
    if (session != null) 
    { Integer userId = (Integer) session.getAttribute("userId"); 
    User user=u.searchByID(userId);
    request.setAttribute("user", user); 
    request.getRequestDispatcher("userInfor.jsp").forward(request, response);
    }
   
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       UserDAO u=new UserDAO();
        int userID;  HttpSession session = request.getSession(false);
    if (session != null) 
    { Integer userId = (Integer) session.getAttribute("userId"); 
    User user=u.searchByID(userId);
    
    user.setEmail(request.getParameter("email"));
    user.setFullName(request.getParameter("full_name"));
    user.setPhoneNum(request.getParameter("phone_number"));
    user.setAddress(request.getParameter("address"));
    u.updateUserInfor(userId, user);
    request.setAttribute("user", user); 
    request.getRequestDispatcher("userInfor.jsp").forward(request, response);
    }
    }

    
    
}
