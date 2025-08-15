/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import data.models.Product;
import java.util.List;

/**
 *
 * @author PC
 */
public interface ProductDao {
    public Product createProduct(String name, String description, String price);
    public Product getProductById(int id);
    public List<Product> getAllProducts();
    public boolean updateProduct(Product product);
    public boolean deleteProduct(int id);
}
