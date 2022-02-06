DROP TABLE IF EXISTS ActorDirector;
CREATE TABLE ActorDirector (
                                 id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                                 first_name VARCHAR(50),
                                 last_name VARCHAR(50),
                                 birth_date DATE NOT NULL,
                                 death_date DATE,
                                 nationality VARCHAR(50),
                                 hidden BOOLEAN,
                                 PRIMARY KEY (id)
);
DROP TABLE IF EXISTS Tag;
CREATE TABLE Tag (
                                  id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                                  tag VARCHAR(30) NOT NULL,
                                  hidden BOOLEAN,
                                  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Movie;
CREATE TABLE Movie (
                        id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                        title VARCHAR(100) NOT NULL,
                        length INTEGER  NOT NULL,
                        description VARCHAR(255),
                        release_date DATE NOT NULL,
--                         min age to watch movie
                        rating integer NOT NULL,
                        hidden BOOLEAN,
                        PRIMARY KEY (id),
                        CONSTRAINT director_id FOREIGN KEY (id) REFERENCES ActorDirector(id)

);
DROP TABLE IF EXISTS Review;
CREATE TABLE Review(
                       id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                       rating integer NOT NULL,
                       review VARCHAR(255),
                       date DATE NOT NULL,


                       hidden BOOLEAN,
                       PRIMARY KEY (id),
                       CONSTRAINT movie_id FOREIGN KEY (id) REFERENCES Movie(id)
);

CREATE TABLE Movie_Tag(
                          id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                          PRIMARY KEY (id),
                          CONSTRAINT movie_id FOREIGN KEY (id) REFERENCES Movie(id),
                          CONSTRAINT tag_id FOREIGN KEY (id) REFERENCES Tag(id)
);

CREATE TABLE Movie_Actor(
                          id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
                          PRIMARY KEY (id),
                          CONSTRAINT movie_id FOREIGN KEY (id) REFERENCES Movie(id),
                          CONSTRAINT actor_id FOREIGN KEY (id) REFERENCES ActorDirector(id)
);
