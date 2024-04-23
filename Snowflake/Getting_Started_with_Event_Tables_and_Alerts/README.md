
- setup database
- schematization
- automating task
- logging to event tables
- alerts
- clean up

Event Tables are a good way to log these bad records as it's efficient to store these single records and it will allow us to tune the amount of logging and alerting we would like to do.

Create the event table for your account. Note this will overwrite the current events table if it has been set. If you share the account with others, use the event table that is already set in upcoming sql commands instead of MY_EVENTS.

ref: https://quickstarts.snowflake.com/guide/alert_on_events/
