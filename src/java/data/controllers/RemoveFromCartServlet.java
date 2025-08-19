/*
 * Servlet xóa sản phẩm khỏi giỏ hàng theo productId (AJAX, trả về JSON)
 */
package data.controllers;

import data.dao.CartDao;
import data.dao.Database;
import data.dao.ProductDao;
import data.implementations.CartImplementation;
import data.models.Cart;
import data.models.CartItem;
import data.models.Product;
import data.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/remove-from-cart"})
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try (PrintWriter out = response.getWriter()) {
            if (user == null) {
                String redirect = request.getContextPath() + "/signin?message=Please%20login%20to%20update%20your%20cart";
                out.write("{\"success\":false,\"requiresLogin\":true,\"redirect\":\"" + redirect + "\"}");
                return;
            }

            String productIdStr = request.getParameter("productId");
            int productId = Integer.parseInt(productIdStr);

            CartDao cartDao = new CartImplementation();
            Cart cart = cartDao.getCartByUserEmail(user.getEmail());
            if (cart == null) {
                out.write("{\"success\":false,\"message\":\"Cart not found\"}");
                return;
            }

            CartItem existing = cartDao.getCartItemByProduct(cart.getId(), productId);
            if (existing == null) {
                int cartItemCount = cartDao.getCartItemCount(cart.getId());
                session.setAttribute("cartItemCount", cartItemCount);
                out.write("{\"success\":true,\"cartItemCount\":" + cartItemCount + ",\"isInCart\":false}");
                return;
            }

            boolean removed = cartDao.removeItemFromCart(existing.getId());
            int cartItemCount = cartDao.getCartItemCount(cart.getId());
            session.setAttribute("cartItemCount", cartItemCount);

            if (removed) {
                out.write("{\"success\":true,\"cartItemCount\":" + cartItemCount + ",\"isInCart\":false}");
            } else {
                out.write("{\"success\":false,\"message\":\"Failed to remove item\"}");
            }
        } catch (Exception e) {
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"success\":false,\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}");
            }
        }
    }
}


