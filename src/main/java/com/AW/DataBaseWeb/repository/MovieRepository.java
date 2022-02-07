package com.AW.DataBaseWeb.repository;

import com.AW.DataBaseWeb.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Integer> {

    @Query("select a from Movie a where a.hidden=false ")
    List<Movie> findAllNotHidden();
}
