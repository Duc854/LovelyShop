package controller;

import dal.ProductDAO;
import dal.ShoppingCartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ShoppingCart;

public class addCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        int userId = (Integer) session.getAttribute("userId");

        // Validate product ID and quantity
        if (productIdStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing product ID or quantity");
            return;
        }

        int productId;
        int quantity;
        try {
            productId = Integer.parseInt(productIdStr);
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or quantity format");
            return;
        }

        // Retrieve product information
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productIdStr);
        if (product == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product not found");
            return;
        }

        // Retrieve or initialize user's cart
        ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();
        List<ShoppingCart> cart = (ArrayList<ShoppingCart>) session.getAttribute("cart");
        if (cart == null) {
            cart = shoppingCartDAO.getCartByUserId(userId);
            if (cart == null) {
                cart = new ArrayList<>();
            }
        }

        boolean productExistsInCart = false;

        // Check if the product already exists in the cart
        for (ShoppingCart cartItem : cart) {
            if (cartItem.getProductId() == productId && "unpaid".equals(cartItem.getStatus())) {
                // Update the quantity and total if product exists
                int newQuantity = cartItem.getQuantity() + quantity;
                cartItem.setQuantity(newQuantity);
                cartItem.setTotal(product.getPrice() * newQuantity); // Update total as well
                shoppingCartDAO.updateAddQuantity(userId,product.getProductId(), newQuantity);


                productExistsInCart = true;
                break;
            }
        }

        // If product does not exist in the cart, add it as a new item
        if (!productExistsInCart) {
            ShoppingCart newCartItem = new ShoppingCart(
                userId,                                // userId
                productId,                             // productId
                product.getSourceImg(),                // srcImg
                quantity,                              // quantity
                product.getProductName(),              // productName
                product.getPrice(),                    // price
                "unpaid"                              // status
            );
            cart.add(newCartItem);
            shoppingCartDAO.insertAddCart(userId, productId, quantity);
        }

        // Update cart in session
        session.setAttribute("cart", cart);

        // Redirect to addCart.jsp
        response.sendRedirect("addCart.jsp");
    }
}
