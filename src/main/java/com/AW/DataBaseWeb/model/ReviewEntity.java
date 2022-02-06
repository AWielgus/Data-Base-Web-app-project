package com.AW.DataBaseWeb.model;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "review", schema = "public", catalog = "AB")
public class ReviewEntity {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "rating")
    private int rating;
    @Basic
    @Column(name = "review")
    private String review;
    @Basic
    @Column(name = "date")
    private Date date;
    @Basic
    @Column(name = "hidden")
    private Boolean hidden;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Boolean getHidden() {
        return hidden;
    }

    public void setHidden(Boolean hidden) {
        this.hidden = hidden;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewEntity that = (ReviewEntity) o;

        if (id != that.id) return false;
        if (rating != that.rating) return false;
        if (review != null ? !review.equals(that.review) : that.review != null) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;
        if (hidden != null ? !hidden.equals(that.hidden) : that.hidden != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + rating;
        result = 31 * result + (review != null ? review.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        result = 31 * result + (hidden != null ? hidden.hashCode() : 0);
        return result;
    }
}
