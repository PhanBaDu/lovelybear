/*
 * Servlet xóa một sản phẩm khỏi giỏ hàng
 */
package data.controllers;

import data.dao.CartDao;
import data.implementations.CartImplementation;
import data.models.Cart;
import data.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "removeCartItemServlet", urlPatterns = {"/remove-cart-item"})
public class removeCartItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/signin?message=Please%20login%20to%20update%20your%20cart");
            return;
        }

        String itemIdStr = request.getParameter("itemId");

        try {
            int itemId = Integer.parseInt(itemIdStr);

            CartDao cartDao = new CartImplementation();
            boolean removed = cartDao.removeItemFromCart(itemId);

            // Refresh cart count in session
            Cart cart = cartDao.getCartByUserEmail(currentUser.getEmail());
            int cartItemCount = 0;
            if (cart != null) {
                cartItemCount = cartDao.getCartItemCount(cart.getId());
            }
            session.setAttribute("cartItemCount", cartItemCount);

            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            System.err.println("Error removing cart item: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/cart?error=Invalid%20request");
        }
    }
}


