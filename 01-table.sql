--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

-- Started on 2022-02-08 16:35:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 216 (class 1255 OID 16979)
-- Name: function1(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.function1(director_id integer) RETURNS TABLE(movie_id integer, avg_rating numeric)
    LANGUAGE plpgsql
    AS $$
declare
movie_id_ integer := null;
    avg_rating_ numeric := null;
begin
select m.id
into movie_id_
from movie m
where m.director_id_id = director_id and m.hidden = false
order by m.release_date desc
    limit 1;
if movie_id_ is null then
        return;
end if;
select avg(r.rating)
from movie m
         join review r on r.movie_id_id = m.id
where m.id = movie_id_ and r.hidden = false
    into avg_rating_;
return query select movie_id_, avg_rating_;
end;$$;


ALTER FUNCTION public.function1(director_id integer) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16980)
-- Name: function2(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.function2(movie_id integer) RETURNS TABLE(first_name character varying, last_name character varying)
    LANGUAGE plpgsql
    AS $$
begin
return query select ad.first_name as first_name, ad.last_name as last_name
                 from movie m
                          join movie_actor ma on m.id = ma.movie_id_id
                          join actordirector ad on ma.director_id_id = ad.id
                 where m.id = movie_id and ad.hidden = false;
end;$$;


ALTER FUNCTION public.function2(movie_id integer) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16978)
-- Name: function3(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.function3(tag_id integer) RETURNS TABLE(movie_id integer, avg_rating numeric)
    LANGUAGE plpgsql
    AS $$
declare
movie_id_ integer;
    avg_rating_ numeric;
begin
select m.id, avg(r.rating) as avg_rating
into movie_id_, avg_rating_
from movie_tag mt
         join movie m on m.id = mt.movie_id_id
         join review r on r.movie_id_id = m.id
where mt.tag_id_id = tag_id and m.hidden = false and r.hidden = false
group by m.id
order by avg_rating desc
    limit 1;

return query select movie_id_ as movie_id, avg_rating_ as avg_rating;
end;$$;


ALTER FUNCTION public.function3(tag_id integer) OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16975)
-- Name: hide_actordirector_related_movie(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: cyboorg
--

CREATE PROCEDURE public.hide_actordirector_related_movie(name character varying, surname character varying)
    LANGUAGE plpgsql
    AS $$
declare
actordirector_id integer := 0;
begin
select id from actordirector
where lower(first_name) = lower(name) and lower(last_name) = lower(surname)
    into actordirector_id
        limit 1;
if actordirector_id is null then
        return;
end if;

update movie
set hidden = true
where director_id_id = actordirector_id
   or id in (select m.id
             from movie m
                      join movie_actor ma on m.id = ma.movie_id_id
                      join actordirector a on a.id = ma.director_id_id
             where a.id = actordirector_id);
end;$$;


ALTER PROCEDURE public.hide_actordirector_related_movie(name character varying, surname character varying) OWNER TO cyboorg;

--
-- TOC entry 215 (class 1255 OID 16976)
-- Name: hide_review_with_word(character varying); Type: PROCEDURE; Schema: public; Owner: cyboorg
--

CREATE PROCEDURE public.hide_review_with_word(word character varying)
    LANGUAGE plpgsql
    AS $$
begin
update review
set hidden = true
where position(lower(word) in lower(review.review)) > 0;
end;$$;


ALTER PROCEDURE public.hide_review_with_word(word character varying) OWNER TO cyboorg;

--
-- TOC entry 213 (class 1255 OID 16974)
-- Name: restore_all_hidden(); Type: PROCEDURE; Schema: public; Owner: cyboorg
--

CREATE PROCEDURE public.restore_all_hidden()
    LANGUAGE plpgsql
    AS $$
begin
    -- restore hidden actor/director
update actordirector
set hidden = false
where hidden = true;

-- restore hidden movies
update movie
set hidden = false
where hidden = true;

-- restore hidden tags
update tag
set hidden = false
where hidden = true;

-- restore reviews
update review
set hidden = false
where hidden = true;
end;$$;


ALTER PROCEDURE public.restore_all_hidden() OWNER TO cyboorg;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16855)
-- Name: actordirector; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.actordirector (
                                      id integer NOT NULL,
                                      alive boolean,
                                      birth_date date,
                                      first_name character varying(255),
                                      hidden boolean,
                                      last_name character varying(255),
                                      nationality character varying(255)
);


ALTER TABLE public.actordirector OWNER TO cyboorg;

--
-- TOC entry 201 (class 1259 OID 16853)
-- Name: actordirector_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.actordirector_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actordirector_id_seq OWNER TO cyboorg;

--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 201
-- Name: actordirector_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.actordirector_id_seq OWNED BY public.actordirector.id;


--
-- TOC entry 200 (class 1259 OID 16401)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO cyboorg;

--
-- TOC entry 204 (class 1259 OID 16866)
-- Name: movie; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.movie (
                              id integer NOT NULL,
                              description character varying(255),
                              hidden boolean,
                              length integer,
                              rating integer,
                              release_date date,
                              title character varying(255),
                              director_id_id integer
);


ALTER TABLE public.movie OWNER TO cyboorg;

--
-- TOC entry 210 (class 1259 OID 16940)
-- Name: movie_actor; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.movie_actor (
                                    id integer NOT NULL,
                                    director_id_id integer,
                                    movie_id_id integer
);


ALTER TABLE public.movie_actor OWNER TO cyboorg;

--
-- TOC entry 209 (class 1259 OID 16938)
-- Name: movie_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.movie_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_actor_id_seq OWNER TO cyboorg;

--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 209
-- Name: movie_actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.movie_actor_id_seq OWNED BY public.movie_actor.id;


--
-- TOC entry 203 (class 1259 OID 16864)
-- Name: movie_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_id_seq OWNER TO cyboorg;

--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 203
-- Name: movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.movie_id_seq OWNED BY public.movie.id;


--
-- TOC entry 212 (class 1259 OID 16948)
-- Name: movie_tag; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.movie_tag (
                                  id integer NOT NULL,
                                  movie_id_id integer,
                                  tag_id_id integer
);


ALTER TABLE public.movie_tag OWNER TO cyboorg;

--
-- TOC entry 211 (class 1259 OID 16946)
-- Name: movie_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.movie_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_tag_id_seq OWNER TO cyboorg;

--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 211
-- Name: movie_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.movie_tag_id_seq OWNED BY public.movie_tag.id;


--
-- TOC entry 206 (class 1259 OID 16893)
-- Name: review; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.review (
                               id integer NOT NULL,
                               date date,
                               hidden boolean,
                               rating integer,
                               review character varying(255),
                               movie_id_id integer
);


ALTER TABLE public.review OWNER TO cyboorg;

--
-- TOC entry 205 (class 1259 OID 16891)
-- Name: review_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_id_seq OWNER TO cyboorg;

--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 205
-- Name: review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.review_id_seq OWNED BY public.review.id;


--
-- TOC entry 208 (class 1259 OID 16901)
-- Name: tag; Type: TABLE; Schema: public; Owner: cyboorg
--

CREATE TABLE public.tag (
                            id integer NOT NULL,
                            hidden boolean,
                            tag character varying(255)
);


ALTER TABLE public.tag OWNER TO cyboorg;

--
-- TOC entry 207 (class 1259 OID 16899)
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: cyboorg
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO cyboorg;

--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 207
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- TOC entry 2890 (class 2604 OID 16858)
-- Name: actordirector id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.actordirector ALTER COLUMN id SET DEFAULT nextval('public.actordirector_id_seq'::regclass);


--
-- TOC entry 2891 (class 2604 OID 16869)
-- Name: movie id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 16943)
-- Name: movie_actor id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor ALTER COLUMN id SET DEFAULT nextval('public.movie_actor_id_seq'::regclass);


--
-- TOC entry 2895 (class 2604 OID 16951)
-- Name: movie_tag id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag ALTER COLUMN id SET DEFAULT nextval('public.movie_tag_id_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 16896)
-- Name: review id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review ALTER COLUMN id SET DEFAULT nextval('public.review_id_seq'::regclass);


--
-- TOC entry 2893 (class 2604 OID 16904)
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- TOC entry 3046 (class 0 OID 16855)
-- Dependencies: 202
-- Data for Name: actordirector; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.actordirector (id, alive, birth_date, first_name, hidden, last_name, nationality) FROM stdin;
1	t	1999-06-22	Adrian	f	Wielgus	Poland
2	t	1979-12-12	Dominik	f	Kowalski	Poland
3	f	1979-12-12	Rossi	f	Carlo	Italy
4	t	1979-12-12	Stefan	f	Colombo	Italy
5	t	1962-01-12	Actor1	f	Actor1	France
6	t	1979-12-22	Actor2	f	Actor2	Poland
7	t	1989-11-13	Actor3	f	Actor3	Poland
8	t	1974-01-15	Actor4	f	Actor4	Poland
9	t	1982-05-28	Actor5	f	Actor5	Poland
10	t	1978-09-02	Actor6	f	Actor6	Poland
11	t	2000-11-08	Actor7	f	Actor7	Poland
12	t	2022-01-31	emanuel	f	stefan	Poland
\.


--
-- TOC entry 3048 (class 0 OID 16866)
-- Dependencies: 204
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.movie (id, description, hidden, length, rating, release_date, title, director_id_id) FROM stdin;
2	Krwawy horror	f	120	18	2016-12-12	Kill Mile	2
6	Komedia romantyczna	f	121	12	2016-02-14	Film3	2
3	Film dla dzieci	f	161	12	2019-12-12	Rzeszów drift	3
4	Film 1	f	93	12	2018-06-12	Film1	4
5	Film 2	f	85	12	2012-07-12	Film2	1
1	Film dla dzieci	f	90	0	2018-12-12	Auta	1
\.


--
-- TOC entry 3054 (class 0 OID 16940)
-- Dependencies: 210
-- Data for Name: movie_actor; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.movie_actor (id, director_id_id, movie_id_id) FROM stdin;
1	5	1
2	8	1
3	1	1
4	7	2
5	10	2
6	11	2
7	11	3
8	10	3
9	5	3
10	6	3
11	2	3
12	5	4
13	6	4
14	7	4
15	8	4
16	8	5
17	10	5
18	11	5
19	7	6
20	11	6
21	12	2
\.


--
-- TOC entry 3056 (class 0 OID 16948)
-- Dependencies: 212
-- Data for Name: movie_tag; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.movie_tag (id, movie_id_id, tag_id_id) FROM stdin;
1	1	5
2	1	4
3	2	1
4	3	1
\.


--
-- TOC entry 3050 (class 0 OID 16893)
-- Dependencies: 206
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.review (id, date, hidden, rating, review, movie_id_id) FROM stdin;
1	2022-02-07	f	7		3
2	2022-02-07	f	10		1
3	2022-02-07	f	1		2
4	2022-02-07	f	8		2
5	2022-02-07	f	8		2
6	2022-02-07	f	9		3
7	2022-02-07	f	9		3
8	2022-02-07	f	10		3
9	2022-02-07	f	3		4
10	2022-02-07	f	6		4
11	2022-02-07	f	6		4
12	2022-02-07	f	5		5
13	2022-02-07	f	6		6
14	2022-02-07	f	5		6
16	2022-02-08	f	1		3
17	2022-02-08	f	1	boom	2
\.


--
-- TOC entry 3052 (class 0 OID 16901)
-- Dependencies: 208
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.tag (id, hidden, tag) FROM stdin;
1	f	Horror
2	f	Komedia
3	f	Romans
4	f	Gore
5	f	Animacja
6	f	Thriller
7	f	Akcji
8	f	Przemoc
9	f	Samochody
\.


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 201
-- Name: actordirector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.actordirector_id_seq', 12, true);


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 200
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 209
-- Name: movie_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_actor_id_seq', 21, true);


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 203
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_id_seq', 6, true);


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 211
-- Name: movie_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_tag_id_seq', 4, true);


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 205
-- Name: review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.review_id_seq', 17, true);


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 207
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.tag_id_seq', 9, true);


--
-- TOC entry 2897 (class 2606 OID 16863)
-- Name: actordirector actordirector_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.actordirector
    ADD CONSTRAINT actordirector_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 16945)
-- Name: movie_actor movie_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 16874)
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- TOC entry 2907 (class 2606 OID 16953)
-- Name: movie_tag movie_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT movie_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 16898)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (id);


--
-- TOC entry 2903 (class 2606 OID 16906)
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- TOC entry 2913 (class 2606 OID 16969)
-- Name: movie_tag fk3rs3xax03rwr3c7twqxlw7uuw; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT fk3rs3xax03rwr3c7twqxlw7uuw FOREIGN KEY (tag_id_id) REFERENCES public.tag(id);


--
-- TOC entry 2910 (class 2606 OID 16954)
-- Name: movie_actor fk9ynrasggoa8verl4fwsja3bp1; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT fk9ynrasggoa8verl4fwsja3bp1 FOREIGN KEY (director_id_id) REFERENCES public.actordirector(id);


--
-- TOC entry 2912 (class 2606 OID 16964)
-- Name: movie_tag fkbbfjvs31uyss8mk9o4xrb5erg; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT fkbbfjvs31uyss8mk9o4xrb5erg FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2911 (class 2606 OID 16959)
-- Name: movie_actor fkctn77v0p8w8g4qc4hsbs5mbtb; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT fkctn77v0p8w8g4qc4hsbs5mbtb FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2909 (class 2606 OID 16933)
-- Name: review fkcyljn9u21jnxgyriu8cn22pev; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fkcyljn9u21jnxgyriu8cn22pev FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2908 (class 2606 OID 16907)
-- Name: movie fkj3c8769n0x658mpttiq35pe5w; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT fkj3c8769n0x658mpttiq35pe5w FOREIGN KEY (director_id_id) REFERENCES public.actordirector(id);


-- Completed on 2022-02-08 16:35:16

--
-- PostgreSQL database dump complete
--

