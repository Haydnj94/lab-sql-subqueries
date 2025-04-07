use sakila;

# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select count(film_id) as num_of_copies, film_id
from inventory
where film_id  = (
    select film_id 
    from film
    where title = 'Hunchback Impossible')
    group by film_id
; 

# List all films whose length is longer than the average length of all the films in the Sakila database.
select film_id, length
from film
where length > (select avg(length) as average_film_length
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

# Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer

select title
from film
where film_id in (select film_id
					from inventory
					where inventory_id in (select inventory_id
											from rental
                                            where customer_id = (select customer_id
																	from payment 
																	group by customer_id
																	order by sum(amount) desc
																	limit 1)))
																	;



# Retrieve the customer_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
having total_amount_spent > (select avg(total_amount) 
							from (select customer_id, sum(amount) as total_amount 
									from payment 
									group by customer_id) as total_amount
)
order by total_amount_spent desc;