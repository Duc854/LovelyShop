<%-- 
    Document   : Review.jsp
    Created on : Oct 17, 2024, 8:45:10 PM
    Author     : thanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>


<%
List<Reviews> review = (List<Reviews>) request.getAttribute("review");

    // Kiểm tra xem có dữ liệu sản phẩm từ servlet không
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    List<Reviews> reviews = (List<Reviews>) request.getAttribute("review");
    List<ShoppingCart> cartView = (ArrayList<ShoppingCart>) session.getAttribute("cart");

%>  

<html >
    <head>
        <title>Lovely Shop</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/base.css" />
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/home1.css" />
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/review.css" />
        <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/fonts/fontawesome-free-6.6.0-web/fontawesome-free-6.6.0-web/css/all.css"
            />
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
                        <i class="header__icon fa-regular fa-user"></i><a href ="userInfor.jsp">
                            My Account</a>
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
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-regular fa-user"></i>
                        <a href="#" class="logout-link" onclick="document.getElementById('logoutForm').submit(); return false;">
                            Log Out
                        </a>
                        <form id="logoutForm" action="login" method="GET" style="display:none;">
                        </form>
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

                    <div class="header__navbar-cart">
                        <a href="addCart.jsp">
                            <i
                                class="header__navbar-cart-icon fa-solid fa-cart-shopping icon-cart"
                                ></i>
                        </a>
                            <%if(cartView==null || cartView.isEmpty()){ %>
                        <div class="cart-dropdown">
                            <div><p>Your cart is empty</p>
                            </div>
                            <%}else{%>
                            <div class="cart-dropdown">
                                <%
                            for(ShoppingCart userCart : cartView){
                                %>
                                <!-- Danh sách sản phẩm trong giỏ hàng -->
                                <div class="cart-item">
                                    <img src="<%= request.getContextPath() %>/<%=userCart.getSrcImg()%>" alt="<%=userCart.getProductName()%>" />
                                    <div class="cart-item-details">
                                        <p><%=userCart.getProductName()%></p>
                                        <p>Quantity: <%=userCart.getQuantity()%></p>
                                        <p>Price: <%=userCart.getPrice()%></p>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="slider">
            <p class="text-heading">New Year 2024 </p>
            <h1 class="rainbow-text">Best Shopping</h1>
            <h4 class="text-sale">Big Sale of This Week 50% off</h4>
            <a href="productView" class="shop-btn">Shop Now</a>
        </div>

    <div class="giua"><h2>Product Reviews</h2></div>

<div class="center-container"> 
    <form action="subreviews" method="post">
        <label for="review_title">Title:</label>
        <input type="text" id="review_title" name="review_title" required>

        <label for="reviewText">Review:</label><br>
        <textarea id="reviewText" name="reviewText" rows="4" cols="50" required></textarea>
        <br>
        <input type="submit" value="Submit Review">
    </form>

    <h2>Existing Reviews</h2>
    <table>               
        <tr>
            <th>STT</th>
            <th>Title</th>
            <th>Review</th>
            <th>Date</th>
        </tr> 
        <% for (Reviews x : review) { %>
        <tr>
            <td id="<%= x.getReview_id() %>"><%= x.getReview_id() %></td>
            <td><%= x.getTitle() %></td>
            <td><%= x.getContent() %></td>
            <td><%= x.getReview_date() %></td>
            <td>
                <form action="reviews" method="POST">          
                    <input type="hidden" name="review_id" value="<%= x.getReview_id() %>">
                    <input type="submit" value="view">
                </form>
            </td>
        </tr>  
        <% } %>  
    </table>
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


