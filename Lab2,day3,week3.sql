
#List each pair of actors that have worked together.

select concat(aa.first_name, ' ', aa.last_name) As Actor1, 
concat(ac.first_name, ' ', ac.last_name) as Actor2
from actor as  aa
inner join film_actor as  fa on aa.actor_id = fa.actor_id
inner join film_actor as ff on fa.film_id = ff.film_id
inner join actor ac on ac.actor_id = ff.actor_id
where fa.actor_id > ff.actor_id;



#For each film, list actor that has acted in more films.

drop view if exists sakila.actor_film_rank;
create view sakila.actor_film_rank as
(
select
	actor_id, 
    count(film_id), 
    film_id,
    rank() over(partition by film_id order by count(film_id) desc) as ranking
from 
	film_actor 
group by 
	actor_id 
);

select * from sakila.actor_film_rank;

select concat(first_name,' ', last_name) as actor , sub1.film_id from actor a join(
select * from ( select
	actor_id, 
    count(film_id), 
    film_id,
    rank() over(partition by film_id order by count(film_id) desc) as ranking
from 
	film_actor 
group by 
	actor_id) sub
where ranking = 1) sub1 on a.actor_id = sub1.actor_id;



