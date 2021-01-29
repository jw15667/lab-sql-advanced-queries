use sakila;

-- List each pair of actors that have worked together.

drop view film_pairs;
create view film_pairs as
select a.actor_id as first_actor, b.actor_id second_actor from film_actor a
join  film_actor b
join film f
on a.film_id = f.film_id
where a.actor_id > b.actor_id
Group by a.actor_id, b.actor_id;

select * from film_pairs;

-- For each film, list actor that has acted in more films.

select a.film_id, b.title, a.actor_id 
from sakila.film_actor as a
join sakila.film as b
on a.film_id = b.film_id
where actor_id in (
	select actor_id from (
		select actor_id, count(film_id) as Counter
		from sakila.film_actor
		group by  actor_id
		order by Counter desc) sub1)
order by actor_id;