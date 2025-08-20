package data.controllers;

import data.dao.Database;
import data.dao.ProductDao;
import data.dao.ProductImageDao;
import data.models.Product;
import data.models.ProductImage;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("q");
        
        try {
            ProductDao productDao = Database.getProductDao();
            ProductImageDao imageDao = Database.getProductImageDao();
            
            List<Product> products;
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                products = productDao.searchProductsByName(searchTerm.trim());
            } else {
                products = productDao.getAllProducts();
            }
            
            // Set search results as request attributes
            request.setAttribute("products", products);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("imageDao", imageDao);
            
            // Forward to search results page
            request.getRequestDispatcher("/search-results.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tìm kiếm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and redirect to home page
            request.setAttribute("error", "Có lỗi xảy ra khi tìm kiếm sản phẩm. Vui lòng thử lại.");
            request.getRequestDispatcher("/").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
