package com.AW.DataBaseWeb.repository;

import com.AW.DataBaseWeb.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovieRepository extends JpaRepository<Movie, Integer> {


}
