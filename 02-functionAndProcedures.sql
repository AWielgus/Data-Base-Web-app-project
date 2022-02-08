create or replace procedure restore_all_hidden()
    language plpgsql as $$
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


create or replace procedure hide_actordirector_related_movie(name varchar(50), surname varchar(50))
    language plpgsql as $$
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

create or replace procedure hide_review_with_word(word varchar(50))
    language plpgsql as $$
begin
    update review
    set hidden = true
    where position(lower(word) in lower(review.review)) > 0;
end;$$;

-- functions
-- wy?wietla ostatni film danego re?ysera i sredni? ocen tego filmu
create or replace function function1(director_id integer)
    returns table (
                      movie_id integer,
                      avg_rating numeric
                  )
    language plpgsql as $$
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

-- lista aktorów dla danego filmu
create or replace function function2(movie_id integer)
    returns table (
                      first_name varchar,
                      last_name varchar
                  )
    language plpgsql as $$
begin
    return query select ad.first_name as first_name, ad.last_name as last_name
                 from movie m
                          join movie_actor ma on m.id = ma.movie_id_id
                          join actordirector ad on ma.director_id_id = ad.id
                 where m.id = movie_id and ad.hidden = false;
end;$$;

-- wy?wietla film z danego tagu o najlepszych ocenach
create or replace function function3(tag_id integer)
    returns integer
    language plpgsql as $$
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
    order by avg_rating
    limit 1;

    return movie_id_;
end;$$;



