-- Create the warehouse and task to run the schematization as needed. 
-- For this use case, it's desired these tickets are ingested within 10 minutes
-- of creation so we will schedule it as such. 
-- Set the warehouse to auto suspend after 30 seconds 
-- as this is the only workload on that warehouse.

CREATE OR REPLACE WAREHOUSE transformer AUTO_SUSPEND = 30;

CREATE OR REPLACE TASK TRANSFORM_TICKETS 
    WAREHOUSE=transformer
    SCHEDULE = '10 minute'
    ALLOW_OVERLAPPING_EXECUTION = FALSE
AS
    CALL TRANSFORM_TICKETS();

-- Every time a task is created or modified, it must be resumed.
-- Resume the task so it will run.
ALTER TASK TRANSFORM_TICKETS RESUME;
-- Verify the task is scheduled.
SHOW TASKS;
-- You can suspend this now as we do not need it for the rest of the guide, 
-- we will be calling the stored procedure manually for testing.

ALTER TASK TRANSFORM_TICKETS SUSPEND;

-- history of the task can be seen in INFORMATION_SCHEMA.

SELECT *
  FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY())
  order by SCHEDULED_TIME DESC;

