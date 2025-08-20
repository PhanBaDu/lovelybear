/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import data.implementations.UserImplementation;
import data.implementations.ProductImplementation;
import data.implementations.ProductImageImplementation;
import data.implementations.OrderImplementation;
import data.implementations.OrderItemImplementation;
import data.implementations.CartImplementation;

/**
 *
 * @author PC
 */
public class Database {
    public static UserDao getUserDao() {
        return new UserImplementation();
    }
    
    public static ProductDao getProductDao() {
        return new ProductImplementation();
    }
    
    public static ProductImageDao getProductImageDao() {
        return new ProductImageImplementation();
    }
    
    public static CartDao getCartDao() {
        return new CartImplementation();
    }
    
    public static OrderDao getOrderDao() {
        return new OrderImplementation();
    }
    
    public static OrderItemDao getOrderItemDao() {
        return new OrderItemImplementation();
    }
}
