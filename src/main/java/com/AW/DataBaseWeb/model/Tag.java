package com.AW.DataBaseWeb.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "tag", schema = "public", catalog = "AB")
public class Tag {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "tag")
    private String name;

    @Column(name = "hidden")
    private Boolean hidden;
}
