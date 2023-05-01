---------------------------------------------------------------------------------------
/* Hello! We're going to practice some SQL with a database
   from Oracle. This database covers:
   - PC component products
   - categories, orders and order items for said products
   - customers and employees
   - warehouses and their inventories
   - locations, countries, regions
   Hoowhee! That's a lot of tables. But when it comes to
   data, the more the merrier :) */
use ot;
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
/*  	*
	1a.) Select the region_id and count of all rows from the countries table. Group 
	by the region_id and order by count descending. Limit to 1 to find the region 
	with the most countries that have company locations. */
---------------------------------------------------------------------------------------

select region_id, count(country_id) as countries_ct from countries group by region_id order by countries_ct desc limit 1;

---------------------------------------------------------------------------------------
/* 	*
	1b.) Looks like we found the region with the most countries, but we don't know 
	the name of the region. Fortunately, that can be found in the regions table. 
	Using the results of the previous problem, find the name of the region with the
	most countries. We want to use an alias of 'region with most locations' for the 
        column label, as well. */
---------------------------------------------------------------------------------------

select region_name, count(country_id) as countries_ct
from countries left join regions on countries.region_id = regions.region_id
group by regions.region_id order by countries_ct desc limit 1;

---------------------------------------------------------------------------------------
/* 	**
	 1c.) Nice job! Now, here's a more difficult one. Using the locations table, 
	 select the state, city, and postal_code from locations where the country is 
	 NOT the United States (country_id != "US") and the name of the city starts
	 with "S". 
         Hint: Use LIKE and a wildcard. */
---------------------------------------------------------------------------------------

select state, city, postal_code from locations where country_id != "US" and country_id like "S%";

---------------------------------------------------------------------------------------
/*  	*
	1d.) As you may have seen in the problem above, there's a "state" column in the 
        locations table, but not all locations are in a state. Select all entries for 
        the locations that are NOT in a state. */
---------------------------------------------------------------------------------------

select * from locations where state is not null;

---------------------------------------------------------------------------------------
/* 	**
	1e.) Your employer wants an update on the number of countries that have locations. 
	They note that they want unique countries but they're not sure how to do that 
	and they're asking you for help. Write a query for them. */
---------------------------------------------------------------------------------------

select distinct country_id, location_id from locations group by country_id;

---------------------------------------------------------------------------------------
/* 	**
	2a.) Why don't we switch gears? Let's take a look at the products in this
	database. Find the product names and prices of all products that have a 
	list_price between 100 and 500. You'll have to find the right table yourself on 
	this one. */
---------------------------------------------------------------------------------------

select product_name, list_price from products where list_price < 500 and list_price > 100;

---------------------------------------------------------------------------------------
/* 	**
	2b.) What do those product names even MEAN? If you don't know much about PC 
       components, it can be difficult to distinguish between different kinds of 
       products. Good thing we have a table for product categories! 
       
       Select the product_name, list_price, and category_name (from product category) 
       rows from the products table joined to the product_categories table on 
       category_id (using an inner join). */
---------------------------------------------------------------------------------------

select product_name, list_price, category_name
from products inner join product_categories
on products.category_id = product_categories.category_id;

---------------------------------------------------------------------------------------
/* 	****
	2c.) Let's try joining more than two tables. You're looking for a popular CPU 
	that has more than 100 units in stock at your local warehouse in Toronto. You 
	only need to find the names of the products, but you'll need to join these 
	tables:
        - warehouses
        - inventories
        - products
        - product_categories
        The only info you need is the product_name and the list_price. */
---------------------------------------------------------------------------------------

select product_name from warehouses
inner join inventories on warehouses.warehouse_id = inventories.warehouse_id
inner join products on products.product_id = inventories.product_id
inner join product_categories on products.category_id = product_categories.category_id
where quantity > 100;

