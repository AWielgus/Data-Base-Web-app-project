package com.AW.DataBaseWeb.repository;

import com.AW.DataBaseWeb.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Integer> {

    @Query("select a from Movie a where a.hidden=false ")
    List<Movie> findAllNotHidden();

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "CALL public.hide_review_with_word(:word);", nativeQuery = true)
    void procedure1(@Param("word") String word);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "CALL public.hide_actordirector_related_movie(:firstname,:lastname);", nativeQuery = true)
    void procedure2(@Param("firstname") String firstname, @Param("lastname") String lastname);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(value = "CALL public.restore_all_hidden();", nativeQuery = true)
    void procedure3();

    @Query(value = "select * from public.function1(:director_id);", nativeQuery = true)
    String func1(@Param("director_id") int director_id);

    @Query(value = "select * from public.function2(:movie_id);", nativeQuery = true)
    List<String> func2(@Param("movie_id") int movie_id);

    @Query(value = "select * from public.function3(:tag_id);", nativeQuery = true)
    String func3(@Param("tag_id") int tag_id);
}
