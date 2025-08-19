/*
 * Servlet xóa toàn bộ giỏ hàng
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

@WebServlet(name = "clearCartServlet", urlPatterns = {"/clear-cart"})
public class clearCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/signin?message=Please%20login%20to%20update%20your%20cart");
            return;
        }

        try {
            CartDao cartDao = new CartImplementation();
            Cart cart = cartDao.getCartByUserEmail(currentUser.getEmail());
            if (cart != null) {
                cartDao.clearCart(cart.getId());
            }

            // After clearing, count is zero
            session.setAttribute("cartItemCount", 0);

            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            System.err.println("Error clearing cart: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/cart?error=Internal%20error");
        }
    }
}


