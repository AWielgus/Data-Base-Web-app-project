package com.AW.DataBaseWeb.repository;

import com.AW.DataBaseWeb.model.Review;
import com.AW.DataBaseWeb.model.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Integer> {

    @Query("select a from Review a where a.hidden=false ")
    List<Tag> findAllNotHidden();
}
