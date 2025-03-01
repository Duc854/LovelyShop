/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.*;
import java.sql.Timestamp;
import java.util.Date;

public class ReviewsDAO extends MyDAO {

    public void deleteReviews(String id) {
        xSql = "DELETE FROM Reviews WHERE review_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, id);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
        public void deleteReviewsByUserId(String id) {
        xSql = "DELETE FROM Reviews WHERE user_id = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, id);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createReviews(Reviews r) {
        xSql = "INSERT INTO Reviews (user_id,review_title,review_text) VALUES (?, ?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, r.getUser_id());
            ps.setString(2, r.getTitle());
            ps.setString(3, r.getContent());

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Reviews> getAllReviews() {
        List<Reviews> reviewList = new ArrayList<>();
        xSql = "SELECT review_id,Reviews.user_id,full_name,review_text,review_date,review_title FROM Reviews JOIN Users on Reviews.user_id = Users.user_id";
        Reviews review;
        int review_id;
        int user_id;

        String content, userName;
        Date review_date;
        String title;
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                review_id = rs.getInt("review_id");
                user_id = rs.getInt("user_id");
                userName = rs.getString("full_name");
                content = rs.getString("review_text");
                review_date = new Date(rs.getTimestamp("review_date").getTime());
                title = rs.getString("review_title");
                review = new Reviews(userName,review_id, user_id, content, review_date, title );
                reviewList.add(review);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviewList;
    }

    public Reviews getReviewById(int Id) {
        Reviews review = null;
        int review_id;
        int user_id;

        String content, userName;
        String title;
        Date review_date;

        xSql = "SELECT review_id,Reviews.user_id,full_name,review_text,review_date,review_title FROM Reviews JOIN Users on Reviews.user_id = Users.user_id where review_id=?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, Id);
            rs = ps.executeQuery();
            while (rs.next()) {
                user_id = rs.getInt("user_id");
                userName = rs.getString("full_name");
                content = rs.getString("review_text");
                review_id = rs.getInt("review_id");
                review_date = new Date(rs.getTimestamp("review_date").getTime());
                title = rs.getString("review_title");
                review = new Reviews(userName,review_id, user_id, content, review_date, title);

            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;

    }

    public List<Reviews> getHomeReviews() {
        List<Reviews> reviewList = new ArrayList<>();
        xSql = "SELECT TOP 3 review_id,Reviews.user_id,full_name,review_text,review_date,review_title FROM Reviews JOIN Users on Reviews.user_id = Users.user_id Order by Reviews.review_date DESC";
        Reviews review;
        int review_id;
        int user_id;
        String content,username;
        String title;
        Date review_date;
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                review_id = rs.getInt("review_id");
                user_id = rs.getInt("user_id");
                username = rs.getString("full_name");
                content = rs.getString("review_text");
                review_date = new Date(rs.getTimestamp("review_date").getTime());
                title = rs.getString("review_title");
                review = new Reviews(review_id, user_id, content, review_date, title);
                reviewList.add(review);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviewList;
    }

    public void updateReview(Reviews x) {
        xSql = "UPDATE Reviews SET review_title = ? , review_text = ? WHERE review_id = ?";
        try {
            ps.setString(1, x.getTitle());
            ps.setString(2, x.getContent());
            ps.setInt(3, x.getReview_id());
            ps = con.prepareStatement(xSql);
            ps.executeUpdate();
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
