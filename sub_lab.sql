use sakila;

# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(film_id) as num_of_copies
from inventory
where film_id = (
    select film_id
    from film
    where title = 'Hunchback Impossible')
;

# List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, length
from film
where length > (select round(avg(length),2) as average_film_length
				from film)
;

# Use a subquery to display all actors who appear in the film "Alone Trip".
select first_name, last_name 
from actor
where actor_id in (select actor_id
					from film_actor
					where film_id = (select film_id
									from film
									where title = 'Alone Trip'))
;

