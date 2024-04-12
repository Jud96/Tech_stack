-- Loading Data
-- Now that we have created the database, table, and stage,
-- we can load the data into the table.

list @citibike_trips;

copy into trips from @citibike_trips file_format=csv PATTERN = '.*csv.*' ;

truncate table trips;
--verify table is clear
select * from trips limit 10;

--change warehouse size from small to large (4x)
-- warehouse is a compute resource in Snowflake that is used to execute SQL queries.
alter warehouse compute_wh set warehouse_size='large';
--load data with large warehouse
show warehouses
copy into trips from @citibike_trips
file_format=CSV;


 
--Create a New Warehouse for Data Analytics
create warehouse compute_wh_large with warehouse_size = 'large' warehouse_type = 'standard' auto_suspend = 60 auto_resume = true;
