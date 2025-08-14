/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import data.implementations.UserImplementation;

/**
 *
 * @author PC
 */
public class Database {
    public static UserDao getUserDao() {
        return new UserImplementation();
    }
}
