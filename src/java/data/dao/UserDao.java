/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;
import data.models.User;
/**
 *
 * @author PC
 */
public interface UserDao {
    public User createUser(String email, String sodienthoai, String fullName, String pictureProfile, String address, String password);
}
