
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

