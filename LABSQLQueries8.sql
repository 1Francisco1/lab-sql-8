-- LAB SQL QUeries 8

-- 1.Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select*from film;
select title, length, dense_rank() over(order by length) as 'Rank' from film
where length != 0 or length != " ";

-- 2.Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
select title, rating, length, dense_rank() over(partition by rating order by length) as 'Rank' from film
where length != 0 or length != " ";

-- 3.How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select*from category;
select*from film_category;
select*from film;

select name, count(title) from sakila.category as a
join film_category as l on a.category_id = l.category_id
join film as d on a.category_id = d.film_id
group by name;

-- 4.Which actor has appeared in the most films? probably count(film) group by actor or order by
select*from actor;
select*from film_actor;
select*from film;

select first_name,last_name, count(title) from actor as a
join film_actor as l on a.actor_id = l.actor_id
join film as d on a.actor_id = d.film_id
group by first_name, last_name
order by count(title) desc
limit 1;

-- 5.Most active customer (the customer that has rented the most number of films)
select*from customer;
select*from rental;

select first_name,last_name, count(rental_date) from customer as a
join rental as l on a.customer_id = l.customer_id
group by first_name,last_name
order by count(rental_date) desc
limit 1;

-- Bonus.Which is the most rented film?
select*from rental;
select*from inventory;
select*from film;

select title, count(rental_date) from film as a
join inventory as l on a.film_id = l.film_id
join rental as d on a.film_id = d.inventory_id
group by title
order by count(rental_date) desc
limit 1;