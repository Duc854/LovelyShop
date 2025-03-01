<%-- 
    Document   : admin.jsp
    Created on : Oct 9, 2024, 1:48:27 PM
    Author     : ADMIN
--%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%
    // Kiểm tra xem có dữ liệu sản phẩm từ servlet không
    List<Reviews> reviews = (List<Reviews>) request.getAttribute("review");
    List<Product> bestSeller = (List<Product>) request.getAttribute("bestSeller");
    List<Product> products = (List<Product>) request.getAttribute("productList");
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    List<User> users = (List<User>) request.getAttribute("userList");
    String userId = (String) request.getAttribute("userId");
    String cartId = (String) request.getAttribute("uIdToGetCart");
    String xAction = (String) request.getAttribute("action");
    String message = (String) request.getAttribute("message");
    String pmessage = (String) request.getAttribute("pmessage");
    List<ShoppingCart> userCart = (List<ShoppingCart>) request.getAttribute("Cart");
    String selectedReviewId = (String) request.getAttribute("rIdToView");
    List<User> xUserSearch = (List<User>) request.getAttribute("userSearchByName");
    List<Product> xProductSearch = (List<Product>) request.getAttribute("xProductSearch");
    Reviews selectedReview = null;

    // Tìm bài đánh giá với review_id được chọn
    if (selectedReviewId != null && reviews != null) {
        for (Reviews review : reviews) {
            if (review.getReview_id() == Integer.parseInt(selectedReviewId)) {
                selectedReview = review;
                break;
            }
        }
    }
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">

        <script>
            function toggleSubOptions(id) {
                var subOptions = document.getElementById(id);
                if (subOptions.style.display === 'none') {
                    subOptions.style.display = 'block';
                } else {
                    subOptions.style.display = 'none';
                }
            }

            function showContent(contentId) {
                var contents = document.querySelectorAll('.content-section');
                contents.forEach(function (content) {
                    content.style.display = 'none';
                });

                document.getElementById(contentId).style.display = 'block';
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Lấy tham số action từ request nếu có
                const action = '<%= (xAction != null && !xAction.isEmpty()) ? xAction : "" %>';

                // Nếu có action, hiển thị section tương ứng
                if (action) {
                    showContent(action);
                }
            });
            window.onload = function () {
                const productId = '<%= request.getAttribute("productId") %>';
                if (productId) {
                    const element = document.getElementById('product-' + productId);
                    const sectionElement = document.getElementById('product-show'); // Lấy phần section

                    if (element && sectionElement) {
                        // Cuộn đến sản phẩm trong danh sách
                        element.scrollIntoView({behavior: 'auto', block: 'center'});  // Nhảy thẳng đến sản phẩm ở giữa màn hình
                        element.style.backgroundColor = "#ffffcc";  // Làm nổi bật sản phẩm

                        // Cuộn section lên đầu trang ngay lập tức
                        sectionElement.scrollIntoView({behavior: 'auto', block: 'start'}); // Cuộn phần section lên đầu trang
                    }
                }
            };
        </script>
    </head>
    <body>
        <div class="admin-container">
            <nav class="sidebar">
                <h3>WELCOME ADMIN</h3><br><br><br><br>
                <ul>
                    <li><a href="#" onclick="toggleSubOptions('user-options')">User Management</a></li>
                    <ul id="user-options" class="sub-options" style="display: none;">
                        <li><a href="#" onclick="showContent('user-show')">User List</a></li>
                        <li><a href="#" onclick="showContent('user-add')">Add User</a></li>
                        <li><a href="#" onclick="showContent('user-search')">User's Transaction History</a></li>
                    </ul>

                    <li><a href="#" onclick="toggleSubOptions('product-options')">Product Management</a></li>
                    <ul id="product-options" class="sub-options" style="display: none;">
                        <li><a href="#" onclick="showContent('product-show')">Product List</a></li>
                        <li><a href="#" onclick="showContent('product-add')">Add Product</a></li>
                        <li><a href="#" onclick="showContent('product-search')">Product Rank</a></li>
                    </ul>

                    <li><a href="#" onclick="toggleSubOptions('category-options')">Category Management</a></li>
                    <ul id="category-options" class="sub-options" style="display: none;">
                        <li><a href="#" onclick="showContent('category-show')">Category List</a></li>
                        <li><a href="#" onclick="showContent('category-add')">Add Category</a></li>
                    </ul>

                    <li><a href="#" onclick="toggleSubOptions('review-options')">Review Management</a></li>
                    <ul id="review-options" class="sub-options" style="display: none;">
                        <li><a href="#" onclick="showContent('review-management')">Review List</a></li>
                        <li><a href="#" onclick="showContent('review-add')">Add Review</a></li>
                        <li><a href="#" onclick="showContent('review-search')">Search Review</a></li>
                    </ul>
                </ul>
                <form action="login" method="Get">
                    <button type="submit" class="logout">Logout</button>
                </form>
                <br>
                <br>
                <form action="home2View" method="post">
                    <button type="submit" class="logout">Home</button>
                </form>
            </nav>

            <div class="content">
                <!-- User management -->
                <div class="user-management-container">
                    <!-- Nội dung quản lý người dùng -->
                    <section  id="user-show" class="content-section" style="display:none;">
                        <h2>User List</h2>
                        <div class="list">   
                            <table border="1">
                                <tr>
                                    <td> User Id </td> <td> Username </td> <td> Password </td>
                                    <td> Email </td> <td> Full Name </td> <td> Phone </td>
                                    <td> Address</td> <td> Created Time </td><td></td>
                                </tr>
                                <%
                                    if (users != null && !users.isEmpty()) {
                                        for (User user: users) {
                                        if(!user. getRole().equals("admin")){
                                %>
                                <tr>
                                    <td> <%= user.getUserId() %> </td> 
                                    <td> <%= user.getUsername() %> </td> 
                                    <td> <%= user.getPassword() %> </td>
                                    <td> <%= user.getEmail() %> </td>
                                    <td> <%= user.getFullName() %> </td> 
                                    <td> <%= user.getPhoneNum() %> </td>
                                    <td> <%= user.getAddress() %> </td>
                                    <td> <%= user.getCreatedTime() %> </td>
                                    <td><form action="adminUserDeleting" method="POST">            <input type="hidden" name="uIdToDel" value="<%= user.getUserId() %>">
                                            <input type="submit" value="X"></form><td>
                                </tr>   
                                <%
                                    }
                                        }
                                    } 
                                %>
                            </table>   
                        </div>

                        <h2>User Searching</h2>
                        <form action="adminUserSearchByName" method="POST">
                            <input type="text" name="uNameToSearch" placeholder="Enter user's name to search">
                            <button type="submit">Search</button>
                        </form>

                        <% if (xUserSearch != null && !xUserSearch.isEmpty()) { %>
                        <div class="list">
                            <table border="1">
                                <tr>
                                    <td>User Id</td>
                                    <td>Username</td>
                                    <td>Password</td>
                                    <td>Email</td>
                                    <td>Full Name</td>
                                    <td>Phone</td>
                                    <td>Address</td>
                                    <td>Created Time</td>
                                </tr>
                                <% for (User user : xUserSearch) { 
                if (!user.getRole().equals("admin")) { %>
                                <tr>
                                    <td><%= user.getUserId() %></td>
                                    <td><%= user.getUsername() %></td>
                                    <td><%= user.getPassword() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><%= user.getFullName() %></td>
                                    <td><%= user.getPhoneNum() %></td>
                                    <td><%= user.getAddress() %></td>
                                    <td><%= user.getCreatedTime() %></td>
                                </tr>
                                <% } } %>
                            </table>
                        </div>
                        <% } %>   

                        <h2>Update User's Information</h2>
                        <div class = "user-update">
                            <form action="adminUpdateUser" method="POST">
                                <label>User ID:</label>
                                <input type="text" name="uIdToUpdate" placeholder="Enter user's ID to update:" value="">
                                <label>Username:</label>
                                <input type="text" name="username" value="" required><br>

                                <label>Password:</label>
                                <input type="password" name="password" value="" required><br>

                                <label>Email:</label>
                                <input type="email" name="email" value="" required><br>

                                <label>Full Name:</label>
                                <input type="text" name="full_name" value=""><br>

                                <label>Phone Number:</label>
                                <input type="text" name="phone_number" value=""><br>

                                <label>Address:</label>
                                <input type="text" name="address" value=""><br>
                                <label>Role:</label>
                                <select name="role">
                                    <option value="customer" >Customer</option>
                                    <option value="admin" >Admin</option>
                                </select><br>

                                <button type="submit">Update</button>
                            </form>
                        </div>
                    </section>
                    <!-- Thêm người dùng -->
                    <section id="user-add" class="content-section" style="display:none;">
                        <h2>Add New User</h2>
                        <form action="adminUserAdding" method="POST">
                            <label for="username">Username:</label>
                            <input type="text" name="username" required><br>

                            <label for="password">Password:</label>
                            <input type="password" name="password" required><br>

                            <label for="email">Email:</label>
                            <input type="email" name="email" required><br>

                            <label for="full_name">Full Name:</label>
                            <input type="text" name="full_name"><br>

                            <label for="phone_number">Phone Number:</label>
                            <input type="text" name="phone_number"><br>

                            <label for="address">Address:</label>
                            <input type="text" name="address"><br>

                            <label for="role">Role:</label>
                            <select name="role">
                                <option value="customer">Customer</option>
                                <option value="admin">Admin</option>
                            </select><br>
                            <%if(xAction != null && !xAction.isEmpty() && message!=null && !message.isEmpty()){%>
                            <p style = "color: red"><%=message%></p>
                            <%}%>
                            <button type="submit">Add User</button>
                        </form>
                    </section>
                    <!-- Kiểm tra giỏ hàng của người dùng -->
                    <section id="user-search" class="content-section" style="display:none;">
                        <h2>User's Transaction History</h2>
                        <div class="users-search">
                            <form action="adminUserSearching" method="POST">
                                <input type="text" name="uIdToGetCart" placeholder="Enter user's ID to show shopping cart:" required value ="<%= (cartId != null && !cartId.isEmpty()) ?  cartId : ""%>">
                                <button type="submit">Detail</button> 
                            </form>
                            <br><br>
                            <%
                                        double cartTotal = 0;
                                      if (userCart != null && !userCart.isEmpty()) {

                            %>
                            <div class="list">   
                                <table border="1">
                                    <tr>
                                        <td>Product Id</td>
                                        <td>Product Name</td>
                                        <td>Price</td>
                                        <td>Quantity</td>
                                        <td>Total</td> 
                                    </tr>
                                    <%
                                    for (ShoppingCart cart : userCart) {
                                        if (cart.getQuantity() > 0 && cart.getStatus().equals("paid") ) {
                                    %>
                                    <tr>
                                        <td><%= cart.getProductId() %></td>
                                        <td><%= cart.getProductName() %></td> 
                                        <td>$<%= String.format("%.2f",cart.getPrice()) %></td> 
                                        <td><%= cart.getQuantity() %></td> 
                                        <td>$<%= String.format("%.2f",cart.getTotal()) %></td> 
                                    </tr>
                                    <%
                                        cartTotal += cart.getTotal();
                                        }
                                    }
                                    %>
                                </table>
                                <h3 class = "cartTotal">Total spending: $<%=String.format("%.2f", cartTotal)%></h3>
                            </div>
                            <%
                                
                        } else { if(cartTotal ==0){
                            // Display message if user cart is empty or user is not found
                            %>
                            <p style="color: red;">Cannot find user or cart is empty!</p>
                            <%}
                        }
                            cartTotal=0;
                            %>
                        </div>
                    </section>

                </div>
                <!-- Category management -->
                <div class="category-management-container">
                    <!-- Display Category List -->
                    <section id="category-show" class="content-section" style="display:none;">
                        <h2>Category List</h2>
                        <div class="list">
                            <table border="1">
                                <tr>
                                    <td>Category ID</td>
                                    <td>Category Name</td>
                                    <td>Description</td>
                                    <td>Category Image</td>
                                    <td></td>
                                </tr>
                                <%
                                    if (categories != null && !categories.isEmpty()) {
                                        for (Category category : categories) {
                                %>
                                <tr>
                                    <td><%= category.getCategoryId() %></td>
                                    <td><%= category.getCategoryName() %></td>
                                    <td><%= category.getDescription() %></td>
                                    <td><%= category.getSourceImg() %></td>
                                    <td>
                                        <form action="adminCategoryDeleting" method="POST">
                                            <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
                                            <input type="submit" value="X">
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </table>
                        </div>
                        <br>

                        <!-- Update Category Information -->
                        <h2>Update Category Information</h2>
                        <div class="category-update">
                            <form action="adminCategoryUpdating" method="POST">
                                <label>Category ID:</label>
                                <input type="text" name="categoryIdToUpdate" placeholder="Enter category ID to update:" required><br>

                                <label>Category Name:</label>
                                <input type="text" name="categoryName" required><br>

                                <label>Description:</label>
                                <input type="text" name="description"><br>

                                <label>Category Image:</label>
                                <input type="text" name="categoryImg"><br>

                                <button type="submit">Update</button>
                            </form>
                        </div>
                    </section>

                    <!-- Add New Category -->
                    <section id="category-add" class="content-section" style="display:none;">
                        <h2>Add New Category</h2>
                        <form action="adminCategoryAdding" method="POST">
                            <label>Category Name:</label>
                            <input type="text" name="categoryName" required><br>

                            <label>Description:</label>
                            <input type="text" name="description"><br>

                            <label>Category Image:</label>
                            <input type="text" name="categoryImg"><br>

                            <button type="submit">Create</button>
                        </form>
                    </section>
                </div>
                <!-- Product management -->
                <div class="product-management-container">
                    <!-- Hiển thị danh sách sản phẩm -->
                    <section id="product-show" class="content-section" style="display:none;">
                        <h2>Product List</h2>
                        <div class="list">   
                            <table border="1">
                                <tr>
                                    <td> Product Id </td> <td> Product Name </td> <td> Description </td>
                                    <td> Price </td> <td> Stock Quantity </td> <td> Category Id </td>
                                    <td> Created At</td> <td> Source Img </td><td></td>
                                </tr>
                                <%
                                    if (products != null && !products.isEmpty()) {
                                        for (Product product: products) { 
                                %>
                                <tr>
                                    <td id="product-<%= product.getProductId() %>"> <%= product.getProductId() %> </td> 
                                    <td> <%= product.getProductName() %> </td> 
                                    <td> <%= product.getDescription() %> </td>
                                    <td>$<%= String.format("%.2f",product.getPrice()) %> </td>
                                    <td><div class ="stock-quantity"> <%= product.getStockQuantity() %> 
                                            <form action="updateQuantity" method="POST" style="display:inline;">
                                                <input type="hidden" name="actionQuantity" value="up">
                                                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                                <button class = "up-arrow" type="submit">▲</button>
                                            </form>
                                            <form action="updateQuantity" method="POST" style="display:inline;">
                                                <input type="hidden" name="actionQuantity" value="down">
                                                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                                <button class = "down-arrow"type="submit">▼</button>
                                            </form></div></td> 
                                    <td> <%= product.getCategoryId() %> </td>
                                    <td> <%= product.getCreatedAt() %> </td>
                                    <td> <%= product.getSourceImg() %> </td>
                                    <td><form action="adminProductDeleting" method="POST">            
                                            <input type="hidden" name="pIdToDel" value="<%= product.getProductId() %>">
                                            <input type="submit" value="X"></form><td>
                                </tr>   
                                <%
                                        }
                                    } 
                                %>
                            </table>   
                        </div>
                        <br>
                        <h2>Product Searching</h2>
                        <form action="adminProductSearchByName" method="POST">
                            <input type="text" name="xProductSearch" placeholder="Enter product name to search">
                            <button type="submit">Search</button>
                        </form>

                        <% if (xProductSearch != null && !xProductSearch.isEmpty()) { %>
                        <div class="list">
                            <table border="1">
                                <tr>
                                    <td>Product Id</td>
                                    <td>Product Name</td>
                                    <td>Description</td>
                                    <td>Price</td>
                                    <td>Stock Quantity</td>
                                    <td>Category Id</td>
                                    <td>Created Time</td>
                                    <td>Source Img</td>
                                </tr>
                                <% for (Product product : xProductSearch) { %>
                                <tr>
                                    <td><%= product.getProductId() %></td>
                                    <td><%= product.getProductName() %></td>
                                    <td><%= product.getDescription() %></td>
                                    <td>$<%= String.format("%.2f", product.getPrice()) %></td>
                                    <td><%= product.getStockQuantity() %></td>
                                    <td><%= product.getCategoryId() %></td>
                                    <td><%= product.getCreatedAt() %></td>
                                    <td><%= product.getSourceImg() %></td>
                                </tr>
                                <% } %>
                            </table>
                        </div>
                        <% } %>
                        <br>
                        <h2>Update Product's Information</h2>
                        <div class = "product-update">
                            <form action="adminProductUpdating" method="POST">
                                <label>Product ID:</label>
                                <input type="text" name="pIdToUpdate" placeholder="Enter product's ID to update:" value="">
                                <label>Product Name:</label>
                                <input type="text" name="productName" value="" required><br>

                                <label>Description:</label>
                                <input type="text" name="description" value="" required><br>

                                <label>Price:</label>
                                <input type="text" name="price" value="" required><br>

                                <label>Quantity:</label>
                                <input type="text" name="quantity" value="" required><br>

                                <label>Category Id:</label>
                                <input type="text" name="categoryId" value=""><br>

                                <label>Source Img:</label>
                                <input type="text" name="sourceImg" value=""><br>

                                <button type="submit">Update</button>
                            </form>
                        </div>
                    </section>

                    <!-- Nội dung quản lý sản phẩm -->
                    <section id="product-add" class="content-section" style="display:none;">
                        <h2>Add New Product</h2>
                        <form action="adminProductAdding" method="POST">
                            <label>Product Name:</label>
                            <input type="text" name="productName" value="" required><br>

                            <label>Description:</label>
                            <input type="text" name="description" value="" required><br>

                            <label>Price:</label>
                            <input type="text" name="price" value="" required><br>

                            <label>Quantity:</label>
                            <input type="text" name="quantity" value="" required><br>

                            <label>Category Id:</label>
                            <input type="text" name="categoryId" value=""><br>

                            <label>Source Img:</label>
                            <input type="text" name="sourceImg" value=""><br>
                            <%if(xAction != null && !xAction.isEmpty() && pmessage!=null && !pmessage.isEmpty()){%>
                            <p style = "color: red"><%=pmessage%></p>
                            <%}%>
                            <button type="submit">Create</button>
                        </form>
                    </section>

                    <section id="product-search" class="content-section" style="display:none;">
                        <h2>Best Seller</h2>
                        <div class="list">   
                            <table border="1">
                                <tr>
                                    <td> Product Id </td> <td> Product Name </td> 
                                    <td> Quantity </td> <td> Total Revenue  </td>
                                </tr>
                                <%
                                    if (bestSeller != null && !bestSeller.isEmpty()) {
                                        for (Product product: bestSeller) { 
                                %>
                                <tr>
                                    <td > <%= product.getProductId() %> </td> 
                                    <td> <%= product.getProductName() %> </td> 
                                    <td><%= product.getStockQuantity() %> </td> 
                                    <td> $<%= String.format("%.2f",product.getPrice()) %> </td>
                                </tr>   
                                <%
                                        }
                                    } 
                                %>
                            </table>
                            <form action="adminServlet" method="Post">
                                <button type="submit">Refresh</button>
                            </form>
                        </div>
                    </section>
                </div>

                <!-- Review management -->     
                <div class="review-management-container">
                    <section id="review-management" class="content-section" style="display:none;">
                        <h2>Review Management</h2>
                        <div class="list">   
                            <table border="1">
                                <tr>
                                    <td> Review Id </td> <td> User Id</td> <td> Title </td>
                                    <td> Created date</td><td>Detail</td> <td></td>
                                </tr>
                                <%
                                    if (reviews != null && !reviews.isEmpty()) {
                                        for (Reviews review : reviews) { 
                                %>
                                <tr>
                                    <td> <%= review.getReview_id() %> </td> 
                                    <td> <%= review.getUser_id() %> </td> 
                                    <td> <%= review.getTitle() %> </td>
                                    <td><%= review.getReview_date()  %></td> 
                                    <td>
                                        <form action="adminReviewDetail" method="POST" >
                                            <input type="hidden" name="rIdToView" value="<%= review.getReview_id() %>">
                                            <input type="submit" value="📝">
                                        </form>
                                    </td>
                                    <td><form action="adminReviewDeleting" method="POST">            
                                            <input type="hidden" name="rIdToDel" value="<%= review.getReview_id() %>">
                                            <input type="submit" value="X"></form><td>
                                </tr>   
                                <%
                                        }
                                    } 
                                %>
                            </table>   
                        </div>

                        <%
                        // Nếu có bài đánh giá được chọn, hiển thị chi tiết bên dưới bảng
                        if (selectedReview != null) {
                        %>
                        <div class="review-details">
                            <h3>Review Details</h3><div class = "review-detail">
                                <p><strong>Review Id:</strong> <%= selectedReview.getReview_id() %></p>
                                <p><strong>User Id:</strong> <%= selectedReview.getUser_id() %></p>
                                <p><strong>Title:</strong> <%= selectedReview.getTitle() %></p>
                                <p><strong>Content:</strong></p>
                                <div>
                                    <%= selectedReview.getContent() %>
                                </div>
                                <p><strong>Created Date:</strong> <%= selectedReview.getReview_date() %></p>
                            </div>
                        </div>
                        <%
                            }
                        %>


                        <h2>Update Review's Information</h2>
                        <div class = "review-update">
                            <form action="adminUpdateReview" method="POST">
                                <label>Review Id:</label>
                                <input type="text" name="rIdToUpdate" placeholder="Enter review's ID to update:" value="">

                                <label>Title:</label>
                                <input type="text" name="title" value="" required><br>

                                <label>Content:</label><br><br>
                                <textarea id="content" name="content" rows="4" cols="183"  required></textarea><br>
                                <button type="submit">Update</button>
                            </form>
                        </div>
                        <br>
                    </section>

                    <section id="review-add" class="content-section" style="display:none;">
                        <h2>Add New Review</h2>
                        <div class = "review-add">
                            <form action="subreviews" method="GET">
                                <label for="review_title">Title:</label>
                                <input type="text" id="review_title" name="review_title" required>

                                <label>Content:</label><br><br>
                                <textarea id="content" name="content" rows="4" cols="183"  required></textarea><br>
                                <br>
                                <input type="submit" value="Submit Review">
                            </form>
                        </div>
                        <br>
                    </section>

                </div>
            </div>
        </div>
    </body>
</html>
