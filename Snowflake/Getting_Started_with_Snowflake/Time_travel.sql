
-- Using Time Travel

-- Drop and Undrop a Table

drop table json_weather_data;
select * from json_weather_data limit 10;


undrop table json_weather_data;
--verify table is undropped

select * from json_weather_data limit 10;


-- Roll Back a Table


use role sysadmin;
use warehouse compute_wh;
use database citibike;
use schema public;
update trips set start_station_name = 'oops';
select
start_station_name as "station",
count(*) as "rides"
from trips
group by 1
order by 2 desc
limit 20;

set query_id =
(select query_id from table(information_schema.query_history_by_session (result_limit=>5))
where query_text like 'update%' order by start_time desc limit 1);


create or replace table trips as
(select * from trips before (statement => $query_id));


select
start_station_name as "station",
count(*) as "rides"
from trips
group by 1
order by 2 desc
limit 20;
