-- creaeting an alert

CREATE OR REPLACE NOTIFICATION INTEGRATION MY_ALERTS
    TYPE=EMAIL
    ENABLED=TRUE
    ALLOWED_RECIPIENTS=('abdbakroo@gmail.com');

CREATE OR REPLACE ALERT BAD_TICKETS_IN_INGEST
  WAREHOUSE = transformer
  SCHEDULE = '10 minute'
  IF( EXISTS (
    SELECT * from ALERT_ON_EVENTS_GUIDE.PUBLIC.MY_EVENTS WHERE TIMESTAMP
        BETWEEN DATEADD(hour, -1, TO_TIMESTAMP_NTZ(CONVERT_TIMEZONE('UTC', current_timestamp())))
        AND TO_TIMESTAMP_NTZ(CONVERT_TIMEZONE('UTC', current_timestamp()))
        AND STARTSWITH(RESOURCE_ATTRIBUTES['snow.executable.name'], 'TRY_PARSE_TICKET(') 
        AND RECORD['severity_text'] = 'WARN'
  ))
  THEN
    CALL SYSTEM$SEND_EMAIL('MY_ALERTS', 'abdbakroo@gmail.com', 'WARN: TRY_PARSE_TICKET', 'Some lift tickets had bad data during the last ingest. Check MY_EVENTS table for more details.');


ALTER ALERT BAD_TICKETS_IN_INGEST RESUME;

SHOW ALERTS;

INSERT OVERWRITE INTO INGESTED_DATA 
VALUES
('{\"txid\":\"74553eec-32a7-42f6-8955-22c315b6cce3\",\"rfid\":\"0xf5cf736859282ae92873bab8\",'),
('{\"txid\":\"74553eec-32a7-42f6-8955-22c315b6cce3\",\"rfid\":\"0xf5cf736859282ae92873bab8\",\"resort\":\"Wilmot\",\"purchase_time\":\"2023-02-29T04:55:21.397493\",\"expiration_time\":\"2023-06-01\",\"days\":7,\"name\":\"Thomas Perry\",\"address\":null,\"phone\":\"909-865-2364x00638\",\"email\":null,\"emergency_contact\":{\"name\":\"Amber Sanchez\",\"phone\":\"993.904.9224x55225\"}}\n');

CALL TRANSFORM_TICKETS();

SELECT * FROM ALERT_ON_EVENTS_GUIDE.PUBLIC.MY_EVENTS;

SELECT *
FROM
  TABLE(INFORMATION_SCHEMA.ALERT_HISTORY(
    SCHEDULED_TIME_RANGE_START
      =>dateadd('hour',-1,current_timestamp())))
ORDER BY SCHEDULED_TIME DESC;
