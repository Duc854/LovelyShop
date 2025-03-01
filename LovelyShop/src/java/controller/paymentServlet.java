package controller;

import dal.ProductDAO;
import dal.ShoppingCartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import model.ShoppingCart;

public class paymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<ShoppingCart> cart = (ArrayList<ShoppingCart>) session.getAttribute("cart");
        ProductDAO productDAO = new ProductDAO();
        
        if (cart == null || cart.size() == 0) {
            // Set attribute to display error message
            session.setAttribute("isPaymentAttempted", true);
            response.sendRedirect("addCart.jsp"); // Redirect back to the cart page
        } else {
            int userId = (Integer) session.getAttribute("userId");
            ShoppingCartDAO shoppingCartDAO = new ShoppingCartDAO();

            // Iterate over cart items to process each product
            for (ShoppingCart item : cart) {
                // Check if the product has a paid record
                boolean exists = shoppingCartDAO.checkIfProductExistsPaid(userId, item.getProductId());

                if (exists) {
                    // If a paid record exists, update the quantity in the paid record
                    shoppingCartDAO.updateQuantityForPaidProduct(userId, item.getProductId(), item.getQuantity());
                    // Delete the old unpaid record
                    shoppingCartDAO.deleteUnpaidProduct(userId, item.getProductId());
                } else {
                    // If not, update the existing unpaid record to 'paid'
                    shoppingCartDAO.updateCartStatusToPaidByUserId(userId, item.getProductId());
                }
            }

            // Call to update stock after payment
            productDAO.updateStockAfterPayment(cart);

            // Clear the cart in the session after payment is processed
            session.setAttribute("cart", null);

            // Set payment success attribute
            session.setAttribute("paymentSuccess", true);
            response.sendRedirect("addCart.jsp");
        }
    }
}
