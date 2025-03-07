
-- 1.	How many records are there in the dataset?
select count(*) from bigmart ;


-- 2.	What are the distinct item types available in the dataset?
select count(distinct item_type) from bigmart;


-- 3.	How many items have a fat content of "Low Fat"?
select count(*) from bigmart where item_fat_content = 'low fat';


-- 4.	How many rows have a missing outlet size?
select count(*) from bigmart where outlet_size is null;


-- 5.	How many items have zero visibility?
select count(*) from bigmart where Item_Visibility = 0;


-- 6.	What are the distinct outlet types present in the dataset?
select distinct outlet_type from bigmart;


-- 7.	How many unique item identifiers exist in the dataset?
select count(distinct item_identifier) from bigmart;


-- 8.	How many items have an MRP greater than 200?
select count(*) from bigmart where item_mrp > 200;


-- 9.	How many outlets were established before the year 2000?
select count(*) from bigmart where Outlet_Establishment_Year < 2000;

-- 10.	What are the unique outlet location types?
select count(distinct outlet_location_type) from bigmart;


-- 11.	Find the total number of items for each item type.
select item_type, count(item_identifier) from bigmart group by Item_Type;


-- 12.	Find the average MRP for each item type.
select avg(item_mrp) as average_mrp, item_type from bigmart group by 2;


-- 13.	Find the total number of items sold for each outlet type.
select count(*), outlet_type from bigmart group by 2;


-- 14.	Find the average item outlet sales for each outlet type.
select avg(item_outlet_sales), outlet_type from bigmart group by 2;


-- 15.	Find the highest item outlet sales recorded for each item type.
select max(item_outlet_sales) from bigmart group by item_type;


-- 16.	Find the total number of items sold in each outlet.
select count(*) as total_items , outlet_identifier from bigmart group by 2;


-- 17.	Find the number of items with an MRP above the average MRP.
select count(*) from bigmart where item_mrp > (select avg(item_mrp) from bigmart) ;


-- 18.	Find the outlets where the total sales exceed 500,000.
select outlet_identifier from bigmart group by 1 having sum(Item_Outlet_Sales) > 500000;


-- 19.	Find the number of distinct item identifiers in each outlet.
select outlet_identifier, count(distinct item_identifier) from bigmart group by 1;


-- 20.	Find the number of items sold in outlets located in Tier 3 cities.
select count(item_identifier) from bigmart where Outlet_Location_Type = 'tier 3';


-- 21.	Find the outlets with more than 500 items listed.
select outlet_identifier from bigmart group by 1 having count(Item_Identifier) > 500;


-- 22.	Find the number of items with a visibility higher than the average visibility.
select count(*) from bigmart where item_visibility > (select avg(Item_Visibility) from bigmart);


-- 23.	Find the most expensive item (based on MRP) sold in each outlet.
select Outlet_Identifier,max(item_mrp) from bigmart group by Outlet_Identifier;


-- 24.	Find the least expensive item (based on MRP) sold in each outlet.
select Outlet_Identifier,min(item_mrp) from bigmart group by Outlet_Identifier;


-- 25.	Find the number of outlets that sell more than 100 unique items.
select outlet_identifier from bigmart group by Outlet_Identifier having count(distinct Item_Identifier) > 100;


-- 26.	Find the number of items with a fat content of "Regular" and an MRP greater than 250.
select count(*) from bigmart where Item_Fat_Content = 'Regular' and Item_MRP > 250;


-- 27.	Find the average visibility of items grouped by item type.
select item_type,
avg(item_visibility) from bigmart group by item_type;


-- 28.	Find the outlet that has the highest total sales.
select outlet_identifier from bigmart group by 1 order by sum(Item_Outlet_Sales) desc limit 1;


-- 29.	Find the item type that contributes the most to total sales.
select item_type from bigmart group by 1 order by sum(Item_Outlet_Sales) desc limit 1;


-- 30.	Find the average sales of items for each combination of outlet type and location type.
select outlet_type, outlet_location_type, avg(item_outlet_sales) from bigmart group by 1,2;


-- 31.	Find the number of items that have zero visibility but an MRP greater than 150.
select count(item_identifier) from bigmart where Item_Visibility = 0 and Item_MRP > 150;


-- 32.	Find the outlet with the highest average item sales.
select outlet_identifier from bigmart group by 1 order by avg(Item_Outlet_Sales) desc limit 1;


-- 33.	Find the number of outlets where the total sales are below the overall average sales.
select outlet_identifier from bigmart group by 1 having sum(Item_Outlet_Sales) < (select avg(Item_Outlet_Sales) from bigmart););


-- 34.	Find the item type with the lowest average sales.
select item_type, avg(item_outlet_sales) from bigmart group by 1 order by 2 desc limit 1;


-- 35.	Find the number of items that have an MRP above 90% of all items.
with tem as
( select item_mrp, ntile(100) over (order by item_mrp) as percentile from bigmart)
select count(*) from tem where percentile > 90;


-- 36.	Find the standard deviation of sales for each item type.
select Item_Type, stddev(item_outlet_sales) from bigmart group by item_type;


-- 37.	Find the correlation between MRP and sales
SELECT 
    (SUM((Item_MRP - x.mean_x) * (Item_Outlet_Sales - y.mean_y)) / 
     (SQRT(SUM(POW(Item_MRP - x.mean_x, 2))) * SQRT(SUM(POW(Item_Outlet_Sales - y.mean_y, 2))))) AS correlation
FROM bigmart
JOIN 
    (SELECT AVG(Item_MRP) AS mean_x FROM bigmart) x
JOIN 
    (SELECT AVG(Item_Outlet_Sales) AS mean_y FROM bigmart) y;


-- 38.	Find the top 5 best-selling items based on total sales.
with tem as
(select item_identifier, dense_rank() over (order by item_outlet_sales desc) as ranking from bigmart)
select * from tem where ranking <6;


-- 39.	Find the top 5 least-selling items based on total sales.
with tem as
(select item_identifier, dense_rank() over (order by item_outlet_sales asc) as ranking from bigmart)
select * from tem where ranking <6;


-- 40.	Find the count of unique items sold in each outlet type.
select outlet_type, count(item_identifier) from bigmart group by 1;


-- 41.	Find the percentage contribution of each outlet to the total sales.
select outlet_identifier, sum(item_outlet_sales)*100/(Select sum(Item_Outlet_Sales) from bigmart) as percentage from bigmart group by 1 ;


-- 42.	Find the percentage of items with missing weight values.
select count(*)*100/(select count(*) from bigmart) from bigmart where Item_Weight is null;


-- 43.	Find the difference in average sales between "Supermarket Type1" and "Grocery Store".
WITH tem AS (
    SELECT 
        ABS(
            (SELECT AVG(Item_Outlet_Sales) FROM bigmart WHERE Outlet_Type = "Supermarket Type1") - 
            (SELECT AVG(Item_Outlet_Sales) FROM bigmart WHERE Outlet_Type = "Grocery Store")
        ) AS absn
)
SELECT absn FROM tem;


-- 44.	Find the items that have an MRP in the top 10% of all MRP values.
with tem as
(select ntile(100) over ( order by item_mrp) as percentile from bigmart)
select count(*) from tem where percentile > 90;


-- 45.	Find the outlets with the lowest total sales.
with tem as
(select outlet_identifier, dense_rank() over (order by item_outlet_sales) as rnk from bigmart )
select * from tem where rnk = 1;


-- 46.	Find the total sales of items where the visibility is higher than the mean visibility.
select sum(item_outlet_sales) from bigmart where Item_Visibility > (select avg(item_visibility) from bigmart);


-- 47.	Find the number of items sold where the outlet establishment year is before 2005.
select count(item_identifier) from bigmart where Outlet_Establishment_Year < 2005;


-- 48.	Find the sales distribution of items based on outlet size.
select outlet_size, sum(item_outlet_sales) from bigmart group by 1;


-- 49.	Find the average number of items sold per year since an outlet was established.
select Outlet_Identifier, sum(Item_Outlet_Sales) / (2025 - min(Outlet_Establishment_Year)) from bigmart group by 1;


-- 50.	Find the outlets where sales exceed twice the average sales of all outlets.
select outlet_identifier from bigmart group by 1 having sum(Item_Outlet_Sales) > 2*(select avg(Item_Outlet_Sales) from bigmart);