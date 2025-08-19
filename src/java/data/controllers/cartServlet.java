/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import data.dao.CartDao;
import data.implementations.CartImplementation;
import data.models.Cart;
import data.models.CartItem;
import data.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
@WebServlet(name = "cartServlet", urlPatterns = {"/cart"})
public class cartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet cartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/signin?message=Please%20login%20to%20view%20your%20cart");
            return;
        }

        List<CartItem> cartItems = null;
        int cartItemCount = 0;
        BigDecimal totalAmount = BigDecimal.ZERO;

        try {
            CartDao cartDao = new CartImplementation();
            Cart userCart = cartDao.getCartByUserEmail(currentUser.getEmail());

            if (userCart != null) {
                cartItems = cartDao.getCartItems(userCart.getId());
                cartItemCount = cartDao.getCartItemCount(userCart.getId());

                if (cartItems != null) {
                    for (CartItem item : cartItems) {
                        totalAmount = totalAmount.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error loading cart: " + e.getMessage());
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartItemCount", cartItemCount);
        request.setAttribute("totalAmount", totalAmount);

        // Update session cart count for header badge
        session.setAttribute("cartItemCount", cartItemCount);

        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
