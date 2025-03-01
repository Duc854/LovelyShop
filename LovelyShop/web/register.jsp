<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<%
    // Kiểm tra xem có dữ liệu sản phẩm từ servlet không
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    List<Reviews> reviews = (List<Reviews>) request.getAttribute("review");
    List<ShoppingCart> cart = (ArrayList<ShoppingCart>) session.getAttribute("cart");
%>
<html>
    <%String message = (String)request.getAttribute("message");%>
    <head>
                <title>Lovely Shop</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/base.css" />
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/home1.css" />
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/register.css" />
        <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/fonts/fontawesome-free-6.6.0-web/fontawesome-free-6.6.0-web/css/all.css"
            />

        <style>
            .error-message {
                padding: 1px;
                color: red;
                display: none; 
                margin-top: 1px; 
                font-size: 14px; 
            }
        </style>
        <script>
            function validateForm(event) {
                var username = document.forms["registerForm"]["username"].value;
                var password = document.forms["registerForm"]["password"].value;
                var confirmPassword = document.forms["registerForm"]["confirmPassword"].value;
                var email = document.forms["registerForm"]["email"].value;
                var fullName = document.forms["registerForm"]["full_name"].value;
                var phoneNumber = document.forms["registerForm"]["phone_number"].value;
                var address = document.forms["registerForm"]["address"].value;
                var usernameError = document.getElementById("usernameError");
                var passwordError = document.getElementById("passwordError");
                var confirmPasswordError = document.getElementById("confirmPasswordError");
                var emailError = document.getElementById("emailError");
                var fullNameError = document.getElementById("fullNameError");
                var phoneNumberError = document.getElementById("phoneNumberError");
                var addressError = document.getElementById("addressError");

                // Ẩn thông báo lỗi mặc định
                usernameError.style.display = "none";
                passwordError.style.display = "none";
                confirmPasswordError.style.display = "none";
                emailError.style.display = "none";
                fullNameError.style.display = "none";
                phoneNumberError.style.display = "none";
                addressError.style.display = "none";

                // Kiểm tra thông tin người dùng
                if (username === "") {
                    usernameError.style.display = "block"; // Hiển thị thông báo lỗi cho tài khoản
                    event.preventDefault(); // Ngăn không cho gửi form
                }
                if (password === "") {
                    passwordError.style.display = "block"; // Hiển thị thông báo lỗi cho mật khẩu
                    event.preventDefault();
                }
                if (confirmPassword === "" || password !== confirmPassword) {
                    confirmPasswordError.style.display = "block"; // Hiển thị thông báo lỗi nếu mật khẩu không khớp
                    event.preventDefault();
                }
                if (email === "") {
                    emailError.style.display = "block"; // Hiển thị thông báo lỗi cho email
                    event.preventDefault();
                }
                if (fullName === "") {
                    fullNameError.style.display = "block"; // Hiển thị thông báo lỗi cho tên đầy đủ
                    event.preventDefault();
                }
                if (phoneNumber === "") {
                    phoneNumberError.style.display = "block"; // Hiển thị thông báo lỗi cho số điện thoại
                    event.preventDefault();
                }
                if (address === "") {
                    addressError.style.display = "block"; // Hiển thị thông báo lỗi cho địa chỉ
                    event.preventDefault();
                }
            }
            window.onload = function () {
                var message = "<%= message != null ? message : "" %>";
                if (message !== "") {
                    document.title = "Registration failed";
                    setTimeout(function () {
                        alert(message); // Hiển thị thông báo qua alert sau khi trang đã tải
                    }, 100); // Thời gian chờ 100ms trước khi hiển thị thông báo
                }
            }
        </script>
    </head>
    <body>
                <div class="header">
            <div class="header__contact">
                <ul class="header__contact-info info-1">
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-solid fa-mobile-screen-button"></i>
                        0123456789
                    </li>
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-solid fa-envelope"></i>
                        LovelyShop@gmail.com
                    </li>
                </ul>
                <ul class="header__contact-info info-2">
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-regular fa-user"></i><a href ="login.jsp#login">
                            Log in</a>
                    </li>
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-regular fa-user"></i><a href ="register.jsp">
                            Register</a>
                    </li>
                    <li class="header__contact-info-icon header-language">
                        <i class="header__icon fa-solid fa-book-open"></i>
                        Languague
                        <i
                            class="angle-down navbar-icon fa-solid fa-caret-down navbar-icon"
                            ></i>
                        <div class="language">
                            <div class="language-detail">English</div>
                            <div class="language-detail">Vietnamese</div>
                        </div>
                    </li>
                    <li class="header__contact-info-icon header-language">
                        <i class="header__icon fa-solid fa-dollar-sign"></i>
                        Currency
                        <i
                            class="angle-down navbar-icon fa-solid fa-caret-down navbar-icon"
                            ></i>
                        <div class="language">
                            <div class="language-detail">USD</div>
                            <div class="language-detail">Euro</div>
                            <div class="language-detail">VN Dong</div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="header__logo">
                <img src="<%= request.getContextPath() %>/img/logo.png" alt="logo" class="header__logo-img" />

                <div class="header__navbar">
                    <ul class="header__navbar-list">
                        <li class="header__navbar-list-item">
                            <a href="home2View">Home</a>
                        </li>
                        <li class="header__navbar-list-item">
                            <a href="productView">Product</a>
                        </li>
                        <li class="header__navbar-list-item">
                            <a href="Review.jsp">Review</a>
                        </li>
                        <li class="header__navbar-list-item">
                            <a href="#contact">Contact</a>
                        </li>
                    </ul>

                    <div class="header__navbar-cart"><a href="addCart.jsp">
                        <i
                            class="header__navbar-cart-icon fa-solid fa-cart-shopping icon-cart"
                            ></i></a>
                    </div>
                </div>
            </div>
        </div>
                

        <div class="slider">
            <p class="text-heading" ">New Year 2024 </p>
            <h1 class="rainbow-text">Best Shopping</h1>
            <h4 class="text-sale">Big Sale of This Week 50% off</h4>
            <a href="productView"  class="shop-btn">Shop Now</a>
            <div type = "hidden" id="register"> </div>
        </div>
                <div class="baoquanh"> 
    <div class="login-container">
        <h2 >Register</h2>
        <form name="registerForm" action="registerServlet" method="post" onsubmit="validateForm(event)">
            <div class="form-row">
                <div class="form-column">
                    <label> Username: </label>
                    <input type="text" name="username" />
                    <span class="error-message" id="usernameError">Please fill the blank!</span>

                    <label> Password: </label> 
                    <input type="password" name="password" />
                    <span class="error-message" id="passwordError">Please fill the blank!</span>

                    <label> Email: </label>
                    <input type="email" name="email" />
                    <span class="error-message" id="emailError">Please fill the blank!</span>

                    <label> Phone Number: </label>
                    <input type="text" name="phone_number" />
                    <span class="error-message" id="phoneNumberError">Please fill the blank!</span>
                </div>
                <div class="form-column">
                    <label> Confirm Password: </label>
                    <input type="password" name="confirmPassword" />
                    <span class="error-message" id="confirmPasswordError">Please enter correct password!</span>

                    <label> Full Name: </label>
                    <input type="text" name="full_name" />
                    <span class="error-message" id="fullNameError">Please fill the blank!</span>

                    <label> Address: </label>
                    <input type="text" name="address" />
                    <span class="error-message" id="addressError">Please fill the blank!</span>

                    <!-- Move the submit button to the second column -->
                    <input type="submit" value="Đăng Ký" />
                </div>
            </div>
        </form>

        <c:if test="${not empty errorMessage}">
            <p style="color: red">${errorMessage}</p>
        </c:if>
    </div>
</div>

            
                        <div class="support">
            <div class="row">
                <div class="single-support">
                    <div class="support-icon">
                        <i class="fa-solid fa-truck"></i>
                    </div>

                    <div class="support-content">
                        <h3>Free Shipping</h3>
                        <p>Get free shipping on all orders—shop now with no extra cost!</p>
                    </div>
                </div>

                <div class="single-support">
                    <div class="support-icon">
                        <i class="fa-solid fa-dollar-sign"></i>
                    </div>

                    <div class="support-content">
                        <h3>Cash On Delivery</h3>
                        <p>
                            Pay for your order upon delivery for added convenience and peace
                            of mind.
                        </p>
                    </div>
                </div>

                <div class="single-support">
                    <div class="support-icon">
                        <i class="fa-solid fa-headphones"></i>
                    </div>

                    <div class="support-content">
                        <h3>Support 24/7</h3>
                        <p>We're here 24/7 to assist you with any questions or concerns.</p>
                    </div>
                </div>

                <div class="single-support">
                    <div class="support-icon">
                        <i class="fa-solid fa-clock"></i>
                    </div>

                    <div class="support-content">
                        <h3>Opening All Week</h3>
                        <p>Open all week for your shopping needs! Visit us anytime.</p>
                    </div>
                </div>
            </div>
        </div>
            
                    <div class="logo">
            <div class="row">
                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/1.png" alt="" />
                </div>

                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/2.png" alt="" />
                </div>

                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/3.png" alt="" />
                </div>

                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/4.png" alt="" />
                </div>

                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/5.png" alt="" />
                </div>

                <div class="logo-img">
                    <img src="<%= request.getContextPath() %>/img/brand/6.png" alt="" />
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="ftr-container">
                <div class="row">
                    <div class="single-ftr">
                        <h4  id = "contact"class="ftr-title">Contacts</h4>
                        <ul>
                            <li>
                                Hoa Lac, Ha Noi, Viet Nam,
                                <br />
                                ASM PRJ301 SE1891
                            </li>
                            <li>
                                (+84) 1234567
                                <br />
                                (+84) 2348813
                            </li>
                            <li>Contact @lovelyshop.com</li>
                        </ul>
                    </div>

                    <div class="single-ftr">
                        <h4 class="ftr-title">Information</h4>
                        <ul>
                            <li>
                                About Us
                                <br />
                                Delivery Information
                            </li>
                            <li>
                                Privacy Policy
                                <br />
                                Terms & Conditions
                            </li>
                            <li>Contact Us</li>
                        </ul>
                    </div>

                    <div class="single-ftr">
                        <h4 class="ftr-title">Services</h4>
                        <ul>
                            <li>
                                Returns
                            </li>
                            <li>
                                Shopping cart
                            </li>
                            <li>
                                Feedback
                            </li>
                            <li>
                                My Account
                            </li>
                        </ul>
                    </div>

                    <div class="single-ftr">
                        <h4 class="ftr-title">Newsletter</h4>
                        <ul>
                            <li>Try Hard To Complete PRJ301 Assignment</li>
                        </ul>
                    </div>
                </div>

                <div class="ftr-btm-area">
                    <div class="btm-area-container">
                        <div class="row">
                            <div class="ftr-social-icon">
                                <ul>
                                    <li>
                                        <a href="">
                                            <i class="fa-brands fa-facebook"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="">
                                            <i class="fa-brands fa-twitter"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="">
                                            <i class="fa-brands fa-linkedin"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="">
                                            <i id ="test" class="fa-brands fa-youtube"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="">
                                            <i class="fa-brands fa-pinterest"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="ftr-social-text">
                                <p class="copyright-text">© Copyright by DTD</p>
                            </div>

                            <div class="payment-method-icon">
                                <img src="<%= request.getContextPath() %>/img/card.png" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
