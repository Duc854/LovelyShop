/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author thanh
 */
public class Reviews {
    private String userName;
    private int review_id;
    private int user_id;    
    private String content;
    private Date review_date ;
    private String title;
    public Reviews() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Reviews(String userName, int review_id, int user_id, String content, Date review_date, String title) {
        this.userName = userName;
        this.review_id = review_id;
        this.user_id = user_id;
        this.content = content;
        this.review_date = review_date;
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getReview_id() {
        return review_id;
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public Reviews(int review_id, int user_id, String content, Date review_date, String title) {
        this.review_id = review_id;
        this.user_id = user_id;
        
        this.content = content;
        this.review_date = review_date;
        this.title = title;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Reviews(int user_id, String content, String title) {
        this.user_id = user_id;
        this.content = content;
        this.title = title;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getReview_date() {
        return review_date;
    }

    public void setReview_date(Date review_date) {
        this.review_date = review_date;
    }
    
    
}
