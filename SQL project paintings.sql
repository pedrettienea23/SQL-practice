select * from artist
select * from canvas_size
select * from image_link
select * from museum
select * from museum_hours
select * from product_size
select * from subject
select * from work

-- Which museums are open on both Sunday and Monday?
select museum.name as museum_name, museum.city from museum_hours mh1
join museum on museum.museum_id = mh1.museum_id -- In order to display the museum name and city
where day = 'Sunday' -- Selecting museums open on Sunday named mh1
and exists (select * from museum_hours mh2 
where mh2.museum_id = mh1.museum_id
and mh2.day = 'Monday') -- Selecting in mh1 which museums have the same ID of those in mh1 and are open on Monday

-- Which museum is open for the longest during a day?
select museum.name as museum_name, -- In order to display the museum name and city
CONVERT(datetime, "close", 100) AS close_time,
CONVERT(datetime, "open", 100) AS open_time,
DATEDIFF(minute, CONVERT(datetime, "open", 100), CONVERT(datetime, "close", 100)) AS duration
FROM museum_hours
join museum on museum.museum_id = museum_hours.museum_id
order by duration desc

-- Which country and city have the most numbers of museums?
select country, count(*) as museum_number
from museum
group by country
order by count(*) desc

select city, count(*) as museum_number
from museum
group by city
order by count(*) desc

-- Which paintings are not displayed in any museum?
Select name, museum_id from work
where museum_id is null

-- How many paintings have an asking price of more than their regular price?
Select * from product_size
where sale_price > regular_price

-- How many paintings have an asking price less than 50% of their regular price?
Select * from product_size
where sale_price < (0.5 * regular_price)