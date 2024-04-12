
-- Working with Roles, Account Admin, & Account Usage
--- Create a New Role and Add a User

use role accountadmin;
create role junior_dba;
select current_user();
grant role junior_dba to user majid;
grant usage on warehouse compute_wh to role junior_dba;


use role junior_dba;
use warehouse compute_wh;
use role accountadmin;
grant usage on database citibike to role junior_dba;
grant usage on database weather to role junior_dba;

use role junior_dba;




-- View the Account Administrator UI

--go to admin tab

-- >> account usage


--Organization: Credit usage across all the accounts in your organization.
-- Consumption: Credits consumed by the virtual warehouses in the current account.
-- Storage: Average amount of data stored in all databases, internal stages, and Snowflake Failsafe in the current account for the past month.
-- Transfers: Average amount of data transferred out of the region (for the current account) into other regions for the past month.
-- Security: Security features enabled in the current account.
--  go to admin tab >> security
--  The Security tab contains network policies created for the Snowflake account. New network policies can be created by selecting 
--  "+ Network Policy" at the top right hand side of the page.
-- Billing: Billing information for the current account.