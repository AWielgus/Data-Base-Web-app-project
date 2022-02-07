package com.AW.DataBaseWeb.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Date;

@Getter
@Setter
@Entity
@Table(name = "movie", schema = "public", catalog = "AB")
public class Movie {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;//

    @Column(name = "title")
    private String title;//

    @Column(name = "length")
    private int length;

    @Column(name = "description")
    private String description;

    @Column(name = "release_date")
    private Date releaseDate;

    @Column(name = "rating")
    private int rating;

    @Column(name = "hidden")
    private Boolean hidden;//

    @ManyToOne
    private ActorDirector director_id;//
}
