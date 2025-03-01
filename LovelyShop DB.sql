
-- Tạo bảng Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(999999,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    role VARCHAR(10) NOT NULL DEFAULT 'customer',
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT chk_role CHECK (role IN ('customer', 'admin'))
); 

-- Tạo bảng Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
	category_img VARCHAR(100)
);

-- Tạo bảng Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    created_at DATETIME DEFAULT GETDATE(),
	sourceImg VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Tạo bảng Shopping_Cart
CREATE TABLE Shopping_Cart (
    cart_id INT ,
    product_id INT,
	PRIMARY KEY (cart_id,product_id, status),
    quantity INT NOT NULL,
	status varchar(10) DEFAULT 'unpaid',
    FOREIGN KEY (cart_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Tạo bảng Reviews
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY identity(1,1),       
	review_title TEXT,
    user_id INT NOT NULL,                         
    rating INT,    
    review_text TEXT,                             
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,    
    FOREIGN KEY (user_id) REFERENCES Users(user_id),      
);

INSERT INTO Categories (category_name, description, category_img)
VALUES 
('Electronics', 'All kinds of electronic devices and gadgets.', 'electronics.jpg'),
('Clothing', 'Fashionable clothing and accessories.', 'clothing.jpg'),
('Books', 'Various genres of books and literature.', 'books.jpg'),
('Home Appliances', 'Appliances for home and kitchen use.', 'home_appliances.jpg');

-- Chèn một số người dùng customer
INSERT INTO Users (username, password, email, full_name, phone_number, address)
VALUES
    ('user1', 'password1', 'user1@example.com', 'User One', '1234567890', 'Address 1'),
    ('user2', 'password2', 'user2@example.com', 'User Two', '1234567891', 'Address 2'),
    ('user3', 'password3', 'user3@example.com', 'User Three', '1234567892', 'Address 3'),
    ('user4', 'password4', 'user4@example.com', 'User Four', '1234567893', 'Address 4'),
    ('user5', 'password5', 'user5@example.com', 'User Five', '1234567894', 'Address 5'),
    ('user6', 'password6', 'user6@example.com', 'User Six', '1234567895', 'Address 6'),
    ('user7', 'password7', 'user7@example.com', 'User Seven', '1234567896', 'Address 7'),
    ('user8', 'password8', 'user8@example.com', 'User Eight', '1234567897', 'Address 8'),
    ('user9', 'password9', 'user9@example.com', 'User Nine', '1234567898', 'Address 9'),
    ('user10', 'password10', 'user10@example.com', 'User Ten', '1234567899', 'Address 10');


--Thêm product
	INSERT INTO Products (product_name, description, price, stock_quantity, category_id, sourceImg)
VALUES 
('Product 1', 'Description for Product 1', 10.99, 100, 1, 'product1.jpg'),
('Product 2', 'Description for Product 2', 15.99, 200, 1, 'product2.jpg'),
('Product 3', 'Description for Product 3', 20.99, 150, 2, 'product3.jpg'),
('Product 4', 'Description for Product 4', 25.99, 75, 2, 'product4.jpg'),
('Product 5', 'Description for Product 5', 30.99, 60, 3, 'product5.jpg'),
('Product 6', 'Description for Product 6', 35.99, 80, 3, 'product6.jpg'),
('Product 7', 'Description for Product 7', 40.99, 40, 4, 'product7.jpg'),
('Product 8', 'Description for Product 8', 45.99, 30, 4, 'product8.jpg'),
('Product 9', 'Description for Product 9', 50.99, 25, 1, 'product9.jpg'),
('Product 10', 'Description for Product 10', 55.99, 15, 1, 'product10.jpg'),
('Product 11', 'Description for Product 11', 60.99, 10, 2, 'product11.jpg'),
('Product 12', 'Description for Product 12', 65.99, 5, 2, 'product12.jpg'),
('Product 13', 'Description for Product 13', 70.99, 8, 3, 'product13.jpg'),
('Product 14', 'Description for Product 14', 75.99, 12, 3, 'product14.jpg'),
('Product 15', 'Description for Product 15', 80.99, 7, 4, 'product15.jpg'),
('Product 16', 'Description for Product 16', 85.99, 14, 4, 'product16.jpg'),
('Product 17', 'Description for Product 17', 90.99, 6, 1, 'product17.jpg'),
('Product 18', 'Description for Product 18', 95.99, 3, 1, 'product18.jpg'),
('Product 19', 'Description for Product 19', 100.99, 1, 2, 'product19.jpg'),
('Product 20', 'Description for Product 20', 105.99, 0, 2, 'product20.jpg'),
('Product 21', 'Description for Product 21', 110.99, 20, 3, 'product21.jpg'),
('Product 22', 'Description for Product 22', 115.99, 18, 3, 'product22.jpg'),
('Product 23', 'Description for Product 23', 120.99, 12, 4, 'product23.jpg'),
('Product 24', 'Description for Product 24', 125.99, 10, 4, 'product24.jpg'),
('Product 25', 'Description for Product 25', 130.99, 5, 1, 'product25.jpg'),
('Product 26', 'Description for Product 26', 135.99, 3, 1, 'product26.jpg'),
('Product 27', 'Description for Product 27', 140.99, 8, 2, 'product27.jpg'),
('Product 28', 'Description for Product 28', 145.99, 7, 2, 'product28.jpg'),
('Product 29', 'Description for Product 29', 150.99, 12, 3, 'product29.jpg'),
('Product 30', 'Description for Product 30', 155.99, 6, 3, 'product30.jpg'),
('Product 31', 'Description for Product 31', 160.99, 18, 4, 'product31.jpg'),
('Product 32', 'Description for Product 32', 165.99, 4, 4, 'product32.jpg'),
('Product 33', 'Description for Product 33', 170.99, 9, 1, 'product33.jpg'),
('Product 34', 'Description for Product 34', 175.99, 11, 1, 'product34.jpg'),
('Product 35', 'Description for Product 35', 180.99, 20, 2, 'product35.jpg'),
('Product 36', 'Description for Product 36', 185.99, 13, 2, 'product36.jpg'),
('Product 37', 'Description for Product 37', 190.99, 8, 3, 'product37.jpg'),
('Product 38', 'Description for Product 38', 195.99, 7, 3, 'product38.jpg'),
('Product 39', 'Description for Product 39', 200.99, 5, 4, 'product39.jpg'),
('Product 40', 'Description for Product 40', 205.99, 3, 4, 'product40.jpg'),
('Product 41', 'Description for Product 41', 210.99, 2, 1, 'product41.jpg'),
('Product 42', 'Description for Product 42', 215.99, 1, 1, 'product42.jpg'),
('Product 43', 'Description for Product 43', 220.99, 0, 2, 'product43.jpg'),
('Product 44', 'Description for Product 44', 225.99, 5, 2, 'product44.jpg'),
('Product 45', 'Description for Product 45', 230.99, 10, 3, 'product45.jpg'),
('Product 46', 'Description for Product 46', 235.99, 8, 3, 'product46.jpg'),
('Product 47', 'Description for Product 47', 240.99, 15, 4, 'product47.jpg'),
('Product 48', 'Description for Product 48', 245.99, 20, 4, 'product48.jpg'),
('Product 49', 'Description for Product 49', 250.99, 25, 1, 'product49.jpg'),
('Product 50', 'Description for Product 50', 255.99, 30, 1, 'product50.jpg');


-- Thêm giỏ hàng
INSERT INTO Shopping_Cart (cart_id, product_id, quantity, status)
VALUES 
(1000001, 41, 33, 'unpaid'),  -- User 1 with Product ID 1
(1000001, 42, 34, 'unpaid'),  -- User 1 with Product ID 2
(1000001, 43, 35, 'unpaid'),  -- User 1 with Product ID 3

(1000002, 44, 36, 'unpaid'),  -- User 2 with Product ID 4
(1000002, 45, 37, 'unpaid'),  -- User 2 with Product ID 5
(1000002, 46, 38, 'unpaid'),  -- User 2 with Product ID 6

(1000003, 47, 39, 'unpaid'),  -- User 3 with Product ID 7
(1000003, 48, 40, 'unpaid'),  -- User 3 with Product ID 8
(1000003, 49, 41, 'unpaid'),  -- User 3 with Product ID 9

(1000004, 40, 42, 'unpaid'),  -- User 4 with Product ID 10
(1000004, 41, 43, 'unpaid'),  -- User 4 with Product ID 11
(1000004, 42, 44, 'unpaid'),  -- User 4 with Product ID 12

(1000004, 43, 45, 'unpaid'),  -- User 5 with Product ID 13
(1000004, 44, 46, 'unpaid'),  -- User 5 with Product ID 14
(1000004, 45, 47, 'unpaid')  -- User 5 with Product ID 15

INSERT INTO Reviews (review_title, user_id, rating, review_text)
VALUES 
    ('Good product', 1000000, 5, 'I am very satisfied with this product. Highly recommend!'),
    ('Average quality', 1000001, 3, 'The quality is okay, but there is room for improvement.'),
    ('Not worth the price', 1000002, 2, 'The product is overpriced for the quality it offers.'),
    ('Excellent service', 1000003, 4, 'The customer service was great, but the product could be better.'),
    ('Very happy', 1000004, 5, 'This product exceeded my expectations. Will buy again.'),
    ('Poor packaging', 1000005, 2, 'The packaging was damaged, but the product was still usable.'),
    ('Good value', 1000000, 4, 'Great value for the price. Satisfied with the purchase.'),
    ('Disappointed', 1000001, 1, 'The product didn’t work as expected. Would not recommend.'),
    ('High quality', 1000002, 5, 'Top-notch quality! Very happy with my purchase.'),
    ('Just okay', 1000003, 3, 'The product is just okay, nothing special.');


-- Hiển thị toàn bộ dữ liệu từ bảng Users
SELECT * FROM Users;

-- Hiển thị toàn bộ dữ liệu từ bảng Categories
SELECT * FROM Categories;

-- Hiển thị toàn bộ dữ liệu từ bảng Products
SELECT * FROM Products;

SELECT * FROM Shopping_Cart
-- Hiển thị toàn bộ dữ liệu từ bảng Shopping_Cart
SELECT * FROM Shopping_Cart join Products on Shopping_Cart.product_id = Products.product_id where Shopping_Cart.[cart_id] = '999999';

SELECT * FROM Shopping_Cart join Products on Shopping_Cart.product_id = Products.product_id where Shopping_Cart.[cart_id] = 1000000
SELECT * FROM Shopping_Cart join Products on Shopping_Cart.product_id = Products.product_id where Shopping_Cart.[cart_id] = ' ? ' 

SELECT TOP 10 s.product_id, p.product_name, SUM(s.quantity) AS total_quantity_sold, p.price
FROM Shopping_Cart s
JOIN Products p ON s.product_id = p.product_id
WHERE s.status = 'paid'
GROUP BY s.product_id, p.product_name, p.price
ORDER BY total_quantity_sold DESC

UPDATE Shopping_Cart
SET status = 'paid'
WHERE status = 'unpaid'


INSERT INTO Products (product_name, description, price, stock_quantity, category_id, sourceImg)
VALUES 
('Product 11', 'Description for Product 11', 60.99, 10, 2, 'img/product/1.jpg'),
('Product 12', 'Description for Product 12', 65.99, 5, 2, 'img/product/2.jpg'),
('Product 13', 'Description for Product 13', 70.99, 8, 3, 'img/product/3.jpg'),
('Product 14', 'Description for Product 14', 75.99, 12, 3, 'img/product/4.jpg'),
('Product 15', 'Description for Product 15', 80.99, 7, 4, 'img/product/5.jpg'),
('Product 16', 'Description for Product 16', 85.99, 14, 4, 'img/product/6.jpg'),
('Product 17', 'Description for Product 17', 90.99, 6, 1, 'img/product/7.jpg'),
('Product 18', 'Description for Product 18', 95.99, 3, 1, 'img/product/8.jpg');


INSERT INTO Users (username, password, email, full_name, phone_number, address, role, created_at)
VALUES ('admin', 'admin', 'admin@example.com', 'Admin User', '0123456789', 'Admin Address', 'admin', GETDATE());

SELECT review_id,Reviews.user_id,full_name,review_text,review_date,review_title FROM Reviews JOIN Users on Reviews.user_id = Users.user_id

update Categories set category_img = 'img/product/1.jpg' where category_id = 1;