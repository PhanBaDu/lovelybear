/*
 * Servlet thêm sản phẩm vào giỏ hàng (AJAX, trả về JSON, không refresh trang)
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

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try (PrintWriter out = response.getWriter()) {
            if (user == null) {
                String redirect = request.getContextPath() + "/signin?message=Please%20login%20to%20add%20items%20to%20cart";
                out.write("{\"success\":false,\"requiresLogin\":true,\"redirect\":\"" + redirect + "\"}");
                return;
            }

            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr != null ? quantityStr : "1");
            if (quantity < 1) quantity = 1;

            ProductDao productDao = Database.getProductDao();
            Product product = productDao.getProductById(productId);
            if (product == null) {
                out.write("{\"success\":false,\"message\":\"Product not found\"}");
                return;
            }

            CartDao cartDao = new CartImplementation();
            Cart cart = cartDao.getCartByUserEmail(user.getEmail());
            if (cart == null) {
                cart = cartDao.createCart(user.getEmail());
                if (cart == null) {
                    out.write("{\"success\":false,\"message\":\"Failed to create cart\"}");
                    return;
                }
            }

            CartItem cartItem = new CartItem(
                cart.getId(),
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                quantity
            );

            boolean success = cartDao.addItemToCart(cartItem);
            int cartItemCount = cartDao.getCartItemCount(cart.getId());
            session.setAttribute("cartItemCount", cartItemCount);

            if (success) {
                out.write("{\"success\":true,\"cartItemCount\":" + cartItemCount + ",\"isInCart\":true}");
            } else {
                out.write("{\"success\":false,\"message\":\"Failed to add product to cart\"}");
            }
        } catch (Exception e) {
            try (PrintWriter out = response.getWriter()) {
                out.write("{\"success\":false,\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}");
            }
        }
    }
}


