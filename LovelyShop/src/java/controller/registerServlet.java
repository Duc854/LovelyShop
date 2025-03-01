/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;
import dal.*;

/**
 *
 * @author ADMIN
 */
public class registerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO u = new UserDAO();
        List<User> uList = u.getAllUsers();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String cfPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("full_name");
        String phoneNum = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String role = "customer";
        // Kiểm tra mật khẩu có khớp hay không
        if (!cfPassword.equals(password)) {
            request.setAttribute("message", "Passwords do not match!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên đăng nhập và email có tồn tại không
        for (User userValid : uList) {
            if (username.equals(userValid.getUsername())) {
                request.setAttribute("message", "Username already exists!!! Please use another username");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (email.equals(userValid.getEmail())) {
                request.setAttribute("message", "Email has been registered!!! Please use another email");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        }

        // Nếu không có vấn đề gì, tạo người dùng mới
        User user = new User(username, password, email, fullName, phoneNum, address,role);
        u.createUser(user);
        request.setAttribute("message", "Your account has been successfully registered!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

}
