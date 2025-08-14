/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.models;

/**
 *
 * @author PC
 */
public class User {
    private String email;
    private String sodienthoai;
    private String fullName;
    private String pictureProfile;
    private String address;
    private String password;
    
    // Default constructor
    public User() {
    }
    
    // Constructor with all parameters
    public User(String email, String sodienthoai, String fullName, String pictureProfile, String address, String password) {
        this.email = email;
        this.sodienthoai = sodienthoai;
        this.fullName = fullName;
        this.pictureProfile = pictureProfile;
        this.address = address;
        this.password = password;
    }
    
    // Constructor without password (for security purposes)
    public User(String email, String sodienthoai, String fullName, String pictureProfile, String address) {
        this.email = email;
        this.sodienthoai = sodienthoai;
        this.fullName = fullName;
        this.pictureProfile = pictureProfile;
        this.address = address;
    }
    
    // Getter and Setter methods
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getSodienthoai() {
        return sodienthoai;
    }
    
    public void setSodienthoai(String sodienthoai) {
        this.sodienthoai = sodienthoai;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getPictureProfile() {
        return pictureProfile;
    }
    
    public void setPictureProfile(String pictureProfile) {
        this.pictureProfile = pictureProfile;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
