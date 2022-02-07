package com.AW.DataBaseWeb.repository;


import com.AW.DataBaseWeb.model.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TagRepository extends JpaRepository<Tag, Integer> {

    @Query("select a from Tag a where a.hidden=false ")
    List<Tag> findAllNotHidden();
}
