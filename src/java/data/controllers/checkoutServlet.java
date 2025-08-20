/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package data.controllers;

import data.dao.CartDao;
import data.implementations.CartImplementation;
import data.models.CartItem;
import data.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra user đã đăng nhập chưa
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin.jsp");
            return;
        }
        
        // Lấy danh sách sản phẩm đã chọn
        String[] selectedItemIds = request.getParameterValues("selectedItems");
        
        if (selectedItemIds == null || selectedItemIds.length == 0) {
            // Nếu không có sản phẩm nào được chọn, redirect về giỏ hàng
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            CartDao cartDao = new CartImplementation();
            List<CartItem> selectedItems = new ArrayList<>();
            
            // Lấy cart của user hiện tại
            data.models.Cart userCart = cartDao.getCartByUserEmail(user.getEmail());
            int userCartId = (userCart != null) ? userCart.getId() : -1;
            
            // Lấy thông tin chi tiết của từng sản phẩm đã chọn
            for (String itemIdStr : selectedItemIds) {
                try {
                    int itemId = Integer.parseInt(itemIdStr);
                    CartItem item = cartDao.getCartItemById(itemId);
                    
                    // Kiểm tra item có thuộc về user hiện tại không
                    if (item != null && item.getCartId() == userCartId) {
                        selectedItems.add(item);
                    }
                } catch (NumberFormatException e) {
                    // Bỏ qua itemId không hợp lệ
                    continue;
                }
            }
            
            // Set attributes để hiển thị trong JSP
            request.setAttribute("selectedItems", selectedItems);
            request.setAttribute("selectedItemIds", selectedItemIds);
            
            // Forward đến trang checkout
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Xử lý lỗi
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
        }
    }
}
