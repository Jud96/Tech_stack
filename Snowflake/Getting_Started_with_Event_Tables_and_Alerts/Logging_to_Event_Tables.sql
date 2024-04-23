
-- create event table 
SHOW PARAMETERS LIKE 'event_table' IN ACCOUNT;
CREATE OR REPLACE EVENT TABLE ALERT_ON_EVENTS_GUIDE.PUBLIC.MY_EVENTS;
ALTER ACCOUNT SET EVENT_TABLE = ALERT_ON_EVENTS_GUIDE.PUBLIC.MY_EVENTS;

-- modify the TRY_PARSE_TICKET to log the bad records.To do so, you can use 
-- the built in Python logging library.These will be set to warnings
-- to make sure it's clear these are not healthy/normal events.
CREATE OR REPLACE FUNCTION TRY_PARSE_TICKET(data string)
returns table (txid varchar, rfid varchar, resort varchar, purchase_time timestamp, expiration_time timestamp, days int, name varchar, address variant, phone varchar, email varchar, emergency_contact variant)
language python
runtime_version=3.8
handler='Parser'
as $$
import json
import logging
from datetime import datetime

class Parser:
    def __init__(self):
        pass

    def process(self, data):
        try:
            d = json.loads(data)
        except json.decoder.JSONDecodeError:
            logging.warning(f"Bad JSON data: {data} in try_parse_ticket")
            return
        try:
            purchase_time = datetime.strptime(d['purchase_time'], "%Y-%m-%dT%H:%M:%S.%f")
            expiration_time = datetime.strptime(d['expiration_time'], "%Y-%m-%d")
        except ValueError:
            logging.warning(f"Bad DATE value in data: {data} in try_parse_ticket")
            return

        yield (d['txid'], d['rfid'], d['resort'], purchase_time, expiration_time, d['days'], d['name'], d['address'], d['phone'], d['email'], d['emergency_contact'])

    def end_partition(self):
        pass
$$;

-- Set the log level to warning on the database so these events will be stored.
ALTER DATABASE ALERT_ON_EVENTS_GUIDE SET LOG_LEVEL = WARN;

-- Insert bad data and schematize to test the warnings are visible in the event table.

INSERT OVERWRITE INTO INGESTED_DATA 
VALUES
('{\"txid\":\"74553eec-32a7-42f6-8955-22c315b6cce3\",\"rfid\":\"0xf5cf736859282ae92873bab8\",'),
('{\"txid\":\"74553eec-32a7-42f6-8955-22c315b6cce3\",\"rfid\":\"0xf5cf736859282ae92873bab8\",\"resort\":\"Wilmot\",\"purchase_time\":\"2023-02-29T04:55:21.397493\",\"expiration_time\":\"2023-06-01\",\"days\":7,\"name\":\"Thomas Perry\",\"address\":null,\"phone\":\"909-865-2364x00638\",\"email\":null,\"emergency_contact\":{\"name\":\"Amber Sanchez\",\"phone\":\"993.904.9224x55225\"}}\n');

CALL TRANSFORM_TICKETS();

SELECT * FROM ALERT_ON_EVENTS_GUIDE.PUBLIC.MY_EVENTS;