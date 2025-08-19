<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dao.Database" %>
<%@ page import="data.models.Product" %>
<%@ page import="java.util.List" %>
<%
// Set response type to JSON
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

try {
    // Lấy danh sách sản phẩm từ database
    ProductDao productDao = Database.getProductDao();
    List<Product> products = productDao.getAllProducts();
    
    // Tạo JSON response thủ công
    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("[");
    
    if (products != null && !products.isEmpty()) {
        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);
            jsonBuilder.append("{");
            jsonBuilder.append("\"id\":").append(product.getId()).append(",");
            jsonBuilder.append("\"name\":\"").append(escapeJson(product.getName())).append("\",");
            jsonBuilder.append("\"description\":\"").append(escapeJson(product.getDescription())).append("\",");
            jsonBuilder.append("\"price\":").append(product.getPrice() != null ? product.getPrice() : 0).append(",");
            jsonBuilder.append("\"imageUrl\":\"").append(escapeJson(product.getImageUrl())).append("\"");
            jsonBuilder.append("}");
            
            if (i < products.size() - 1) {
                jsonBuilder.append(",");
            }
        }
    }
    
    jsonBuilder.append("]");
    
    // Trả về JSON response
    out.print(jsonBuilder.toString());
    
} catch (Exception e) {
    // Trả về error response
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    out.print("{\"error\": \"Không thể tải danh sách sản phẩm: " + escapeJson(e.getMessage()) + "\"}");
}

// Helper method để escape JSON string
%><%!
private String escapeJson(String input) {
    if (input == null) return "";
    return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
}
%>
