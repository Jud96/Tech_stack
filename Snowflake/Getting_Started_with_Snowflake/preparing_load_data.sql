--Preparing to Load Data
--Let's start by preparing to load the structured Citi Bike rider 
--transaction data into Snowflake.

-- Create a Database and Table
use role sysadmin;
use warehouse compute_wh;
create database CITIBIKE ;

create or replace table trips
(tripduration integer,
starttime timestamp,
stoptime timestamp,
start_station_id integer,
start_station_name string,
start_station_latitude float,
start_station_longitude float,
end_station_id integer,
end_station_name string,
end_station_latitude float,
end_station_longitude float,
bikeid integer,
membership_type string,
usertype string,
birth_year integer,
gender integer);

--Create an External Stage
--We are working with structured, comma-delimited data that
-- has already been staged in a public, external S3 bucket. 

-- stage is a Snowflake object that points to a location where data files are stored.
create or replace stage citibike_stage url='s3://snowflake-workshop-lab/citibike/';

-- verify stage is created
list @citibike_stage;


-- create a file format
-- file format is a set of instructions that define how to parse the data files in the stage.
create or replace file format csv type='csv'
  compression = 'auto' field_delimiter = ',' record_delimiter = '\n'
  skip_header = 0 field_optionally_enclosed_by = '\042' trim_space = false
  error_on_column_count_mismatch = false escape = 'none' escape_unenclosed_field = '\134'
  date_format = 'auto' timestamp_format = 'auto' null_if = ('') comment = 'file format for ingesting data for zero to snowflake';


--verify file format is created

show file formats in database citibike;