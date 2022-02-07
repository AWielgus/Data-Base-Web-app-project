--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

-- Started on 2022-02-07 21:08:10

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
-- TOC entry 3056 (class 0 OID 0)
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
-- TOC entry 3057 (class 0 OID 0)
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
-- TOC entry 3058 (class 0 OID 0)
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
-- TOC entry 3059 (class 0 OID 0)
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
-- TOC entry 3060 (class 0 OID 0)
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
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 207
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cyboorg
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- TOC entry 2884 (class 2604 OID 16858)
-- Name: actordirector id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.actordirector ALTER COLUMN id SET DEFAULT nextval('public.actordirector_id_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 16869)
-- Name: movie id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);


--
-- TOC entry 2888 (class 2604 OID 16943)
-- Name: movie_actor id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor ALTER COLUMN id SET DEFAULT nextval('public.movie_actor_id_seq'::regclass);


--
-- TOC entry 2889 (class 2604 OID 16951)
-- Name: movie_tag id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag ALTER COLUMN id SET DEFAULT nextval('public.movie_tag_id_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 16896)
-- Name: review id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review ALTER COLUMN id SET DEFAULT nextval('public.review_id_seq'::regclass);


--
-- TOC entry 2887 (class 2604 OID 16904)
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- TOC entry 3040 (class 0 OID 16855)
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
\.


--
-- TOC entry 3042 (class 0 OID 16866)
-- Dependencies: 204
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.movie (id, description, hidden, length, rating, release_date, title, director_id_id) FROM stdin;
1	Film dla dzieci	f	90	0	2018-12-12	Auta	1
2	Krwawy horror	f	120	18	2016-12-12	Kill Mile	2
3	Film dla dzieci	f	161	12	2019-12-12	Rzeszów drift	3
4	Film 1	f	93	12	2018-06-12	Film1	4
5	Film 2	f	85	12	2012-07-12	Film2	1
6	Komedia romantyczna	f	121	12	2016-02-14	Film3	2
\.


--
-- TOC entry 3048 (class 0 OID 16940)
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
\.


--
-- TOC entry 3050 (class 0 OID 16948)
-- Dependencies: 212
-- Data for Name: movie_tag; Type: TABLE DATA; Schema: public; Owner: cyboorg
--

COPY public.movie_tag (id, movie_id_id, tag_id_id) FROM stdin;
\.


--
-- TOC entry 3044 (class 0 OID 16893)
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
\.


--
-- TOC entry 3046 (class 0 OID 16901)
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
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 201
-- Name: actordirector_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.actordirector_id_seq', 11, true);


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 200
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 209
-- Name: movie_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_actor_id_seq', 20, true);


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 203
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_id_seq', 6, true);


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 211
-- Name: movie_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.movie_tag_id_seq', 1, false);


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 205
-- Name: review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.review_id_seq', 14, true);


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 207
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cyboorg
--

SELECT pg_catalog.setval('public.tag_id_seq', 9, true);


--
-- TOC entry 2891 (class 2606 OID 16863)
-- Name: actordirector actordirector_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.actordirector
    ADD CONSTRAINT actordirector_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 16945)
-- Name: movie_actor movie_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT movie_actor_pkey PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 16874)
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 16953)
-- Name: movie_tag movie_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT movie_tag_pkey PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 16898)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (id);


--
-- TOC entry 2897 (class 2606 OID 16906)
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- TOC entry 2907 (class 2606 OID 16969)
-- Name: movie_tag fk3rs3xax03rwr3c7twqxlw7uuw; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT fk3rs3xax03rwr3c7twqxlw7uuw FOREIGN KEY (tag_id_id) REFERENCES public.tag(id);


--
-- TOC entry 2904 (class 2606 OID 16954)
-- Name: movie_actor fk9ynrasggoa8verl4fwsja3bp1; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT fk9ynrasggoa8verl4fwsja3bp1 FOREIGN KEY (director_id_id) REFERENCES public.actordirector(id);


--
-- TOC entry 2906 (class 2606 OID 16964)
-- Name: movie_tag fkbbfjvs31uyss8mk9o4xrb5erg; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_tag
    ADD CONSTRAINT fkbbfjvs31uyss8mk9o4xrb5erg FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2905 (class 2606 OID 16959)
-- Name: movie_actor fkctn77v0p8w8g4qc4hsbs5mbtb; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie_actor
    ADD CONSTRAINT fkctn77v0p8w8g4qc4hsbs5mbtb FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2903 (class 2606 OID 16933)
-- Name: review fkcyljn9u21jnxgyriu8cn22pev; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fkcyljn9u21jnxgyriu8cn22pev FOREIGN KEY (movie_id_id) REFERENCES public.movie(id);


--
-- TOC entry 2902 (class 2606 OID 16907)
-- Name: movie fkj3c8769n0x658mpttiq35pe5w; Type: FK CONSTRAINT; Schema: public; Owner: cyboorg
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT fkj3c8769n0x658mpttiq35pe5w FOREIGN KEY (director_id_id) REFERENCES public.actordirector(id);


-- Completed on 2022-02-07 21:08:10

--
-- PostgreSQL database dump complete
--

