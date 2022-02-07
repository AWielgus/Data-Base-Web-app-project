package com.AW.DataBaseWeb.repository;

import com.AW.DataBaseWeb.model.ActorDirector;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ActorDirectorRepository extends JpaRepository<ActorDirector, Integer> {

    @Query("select a from ActorDirector a where a.hidden=false ")
    List<ActorDirector> findAllNotHidden();

}
