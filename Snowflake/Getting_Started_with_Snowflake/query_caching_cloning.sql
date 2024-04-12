--Working with Queries, the Results Cache, & Cloning

use role sysadmin;
use warehouse compute_wh_large;
use database citibike;
use schema public;

select * from trips limit 20;

-- For each hour, it shows the number of trips, average trip duration, and average trip distance.
select date_trunc('hour', starttime) as "date",
count(*) as "num trips",
avg(tripduration)/60 as "avg duration (mins)",
avg(haversine(start_station_latitude, start_station_longitude, end_station_latitude, end_station_longitude)) as "avg distance (km)"
from trips
group by 1 order by 1;


-- Use the Result Cache
-- Snowflake has a result cache that holds the results of every query executed in the past 24 hours
select date_trunc('hour', starttime) as "date",
count(*) as "num trips",
avg(tripduration)/60 as "avg duration (mins)",
avg(haversine(start_station_latitude, start_station_longitude, end_station_latitude, end_station_longitude)) as "avg distance (km)"
from trips
group by 1 order by 1;


select
monthname(starttime) as "month",
count(*) as "num trips"
from trips
group by 1 order by 2 desc;


-- Clone a Table
create table trips_dev clone trips;