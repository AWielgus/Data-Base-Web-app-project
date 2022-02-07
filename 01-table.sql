
-- Database: AB

-- DROP DATABASE "AB";

CREATE DATABASE "AB"
    WITH
    OWNER = cyboorg
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1252'
    LC_CTYPE = 'Polish_Poland.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- SCHEMA: public

-- DROP SCHEMA public ;

CREATE SCHEMA public
    AUTHORIZATION postgres;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT ALL ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO postgres;

-- Table: public.tag

-- DROP TABLE public.tag;

CREATE TABLE IF NOT EXISTS public.tag
(
    id integer NOT NULL DEFAULT nextval('tag_id_seq'::regclass),
    hidden boolean,
    tag character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT tag_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE public.tag
    OWNER to cyboorg;

-- Table: public.actordirector

-- DROP TABLE public.actordirector;

CREATE TABLE IF NOT EXISTS public.actordirector
(
    id integer NOT NULL DEFAULT nextval('actordirector_id_seq'::regclass),
    birth_date date,
    death_date date,
    first_name character varying(255) COLLATE pg_catalog."default",
    hidden boolean,
    last_name character varying(255) COLLATE pg_catalog."default",
    nationality character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT actordirector_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE public.actordirector
    OWNER to cyboorg;

-- Table: public.movie

-- DROP TABLE public.movie;

CREATE TABLE IF NOT EXISTS public.movie
(
    id integer NOT NULL DEFAULT nextval('movie_id_seq'::regclass),
    description character varying(255) COLLATE pg_catalog."default",
    hidden boolean,
    length integer,
    rating integer,
    release_date date,
    title character varying(255) COLLATE pg_catalog."default",
    director_id_id integer,
    CONSTRAINT movie_pkey PRIMARY KEY (id),
    CONSTRAINT fkj3c8769n0x658mpttiq35pe5w FOREIGN KEY (director_id_id)
    REFERENCES public.actordirector (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

ALTER TABLE public.movie
    OWNER to cyboorg;

-- Table: public.movie_actor

-- DROP TABLE public.movie_actor;

CREATE TABLE IF NOT EXISTS public.movie_actor
(
    id integer NOT NULL DEFAULT nextval('movie_actor_id_seq'::regclass),
    director_id_id integer,
    movie_id_id integer,
    CONSTRAINT movie_actor_pkey PRIMARY KEY (id),
    CONSTRAINT fk9ynrasggoa8verl4fwsja3bp1 FOREIGN KEY (director_id_id)
    REFERENCES public.actordirector (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT fkctn77v0p8w8g4qc4hsbs5mbtb FOREIGN KEY (movie_id_id)
    REFERENCES public.movie (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

ALTER TABLE public.movie_actor
    OWNER to cyboorg;

-- Table: public.movie_tag

-- DROP TABLE public.movie_tag;

CREATE TABLE IF NOT EXISTS public.movie_tag
(
    id integer NOT NULL DEFAULT nextval('movie_tag_id_seq'::regclass),
    movie_id_id integer,
    tag_id_id integer,
    CONSTRAINT movie_tag_pkey PRIMARY KEY (id),
    CONSTRAINT fk3rs3xax03rwr3c7twqxlw7uuw FOREIGN KEY (tag_id_id)
    REFERENCES public.tag (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT fkbbfjvs31uyss8mk9o4xrb5erg FOREIGN KEY (movie_id_id)
    REFERENCES public.movie (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

ALTER TABLE public.movie_tag
    OWNER to cyboorg;

-- Table: public.review

-- DROP TABLE public.review;

CREATE TABLE IF NOT EXISTS public.review
(
    id integer NOT NULL DEFAULT nextval('review_id_seq'::regclass),
    date date,
    hidden boolean,
    rating integer,
    review character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT review_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE public.review
    OWNER to cyboorg;

-- dodawanie warto?ci

INSERT INTO actordirector (first_name,last_name,birth_date, alive,hidden,nationality) Values
    ('Adrian','Wielgus','1999-06-22',true,false,'Poland'),
    ('Dominik','Kowalski','1979-12-12',true,false,'Poland'),
    ('Rossi','Carlo','1979-12-12',false,false,'Italy'),
    ('Stefan','Colombo','1979-12-12',true,false,'Italy'),
    ('Actor1','Actor1','1962-01-12',true,false,'France'),
    ('Actor2','Actor2','1979-12-22',true,false,'Poland'),
    ('Actor3','Actor3','1989-11-13',true,false,'Poland'),
    ('Actor4','Actor4','1974-01-15',true,false,'Poland'),
    ('Actor5','Actor5','1982-05-28',true,false,'Poland'),
    ('Actor6','Actor6','1978-09-02',true,false,'Poland'),
    ('Actor7','Actor7','2000-11-08',true,false,'Poland');


Insert into movie (title,description,length,rating,hidden,director_id_id,release_date) values
      ('Auta','Film dla dzieci',90,0,false,1,'2018-12-12'),
      ('Kill Mile','Krwawy horror',120,18,false,2,'2016-12-12'),
      ('Rzeszów drift','Film dla dzieci',161,12,false,3,'2019-12-12'),
      ('Film1','Film 1',93,12,false,4,'2018-06-12'),
      ('Film2','Film 2',85,12,false,1,'2012-07-12'),
      ('Film3','Komedia romantyczna',121,12,false,2,'2016-02-14');
