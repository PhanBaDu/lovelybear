/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import data.models.ProductImage;
import java.util.List;

/**
 *
 * @author PC
 */
public interface ProductImageDao {
    public ProductImage createProductImage(int productId, String imageUrl);
    public ProductImage getProductImageById(int id);
    public List<ProductImage> getProductImagesByProductId(int productId);
    public boolean updateProductImage(ProductImage productImage);
    public boolean deleteProductImage(int id);
    public boolean deleteProductImagesByProductId(int productId);
}
