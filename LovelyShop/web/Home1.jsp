<%-- 
    Document   : Home1
    Created on : Oct 6, 2024, 12:52:49 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<!DOCTYPE html>
<%
    // Kiểm tra xem có dữ liệu sản phẩm từ servlet không
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    List<Reviews> reviews = (List<Reviews>) request.getAttribute("review");
%>
<html >
    <head>
        <title>Lovely Shop</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/base.css" />
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/home1.css" />
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
                        <i class="header__icon fa-regular fa-user"></i><a href ="login.jsp#login">
                            Log in</a>
                    </li>
                    <li class="header__contact-info-icon">
                        <i class="header__icon fa-regular fa-user"></i><a href ="register.jsp#register">
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
            <h4 class="text-sale"">Big Sale of This Week 50% off</h4>
            <a href="productView" class="shop-btn">Shop Now</a>
        </div>

        <div class="container">
            <div class="row">
                <%
                 if (categories != null && !categories.isEmpty()) {
                     for (Category category: categories) {
                %>
                <div class="single-promo">
                    <img src="<%= request.getContextPath() %>/<%=category.getSourceImg()%>" alt="<%=category.getCategoryName()%>" />
                    <br>
                    <br>
                    <br>
                    <div class="promo-content">
                        <h3 class="title"><%=category.getCategoryName()%></h3>
                        <form action="productViewCategory" method="GET">
                            <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
                            <button type="submit" class="promo-btn">
                                Shop Now
                                <i class="fa-regular fa-circle-right"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <%
}
} 
                %>
            </div>
        </div>

        <div class="product">   
            <%
            // Kiểm tra xem có dữ liệu sản phẩm từ servlet không
            List<Product> products = (List<Product>) request.getAttribute("productList");
            %>
            <div class="section-title">
                <h2>Our Products</h2>
            </div>

            <div class="row">
                <%
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                %>
                <div class="single-product">
                    <div class="product-img">
                        <img src="<%= request.getContextPath() %>/<%= product.getSourceImg() %>" alt="<%= product.getProductName() %>" />
                    </div>
                    <div class="product-detail">
                        <h4><%= product.getProductName() %></h4>
                        <div class="product-rating">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <span class="product-prize">$<%= product.getPrice() %></span>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p>No products available.</p>
                <%
                    }
                %>
            </div>
        </div>

        <div class="blog">
            <div class="section-title">
                <h2>Lastest Review</h2>
            </div>

            <div class="row">
                <%if(reviews!=null && !reviews.isEmpty()){
                int count = 1;
                for (Reviews review: reviews){ %>
                <div class="single-blog">
                    <div class="blog-img">
                        <img src="<%= request.getContextPath() %>/img/blog/blog<%=count%>.jpg" alt="" />
                    </div>
                    <div class="blog-content">
                        <span class="blog-date"><%=review.getReview_date()%></span>
                        <br>
                        <br>
                        <a href = "Review.jsp#<%= review.getReview_id() %>" class="post-title">
                            <%= review.getTitle()%>
                        </a>
                        <ul class="post-bar">
                            <li>
                                <i class="fa-regular fa-user"></i>
                                Author
                            </li>
                            <li>
                                <i class="fa-regular fa-comment"></i>
                                Comments
                            </li>
                            <li>
                                <i class="fa-regular fa-heart"></i>
                                React
                            </li>
                        </ul>
                    </div>
                </div>
                <%
                    count += 1;
                    if(count>3) count =1;}
                        }
                %>        
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

