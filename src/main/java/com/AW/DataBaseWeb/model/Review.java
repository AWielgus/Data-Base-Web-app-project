package com.AW.DataBaseWeb.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Date;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "review", schema = "public", catalog = "AB")
public class Review {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "rating")
    private int rating;

    @Column(name = "review")
    private String text;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "hidden")
    private Boolean hidden;

    @ManyToOne
    private Movie movie_id;
}
