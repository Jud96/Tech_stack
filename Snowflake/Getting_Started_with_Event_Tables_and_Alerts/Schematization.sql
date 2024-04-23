-- Schematization
-- In order to separate the good and bad records, a python user 
-- defined table function will be used to parse and return records. 
-- This example will use an exception handler for bad json and some date checks 
-- to look forinvalid records. We will schematize and store the valid data.

CREATE OR REPLACE FUNCTION TRY_PARSE_TICKET(data string)
returns table (txid varchar, rfid varchar, resort varchar, purchase_time timestamp, expiration_time timestamp, days int, name varchar, address variant, phone varchar, email varchar, emergency_contact variant)
language python
runtime_version=3.8
handler='Parser'
as $$
import json
from datetime import datetime

class Parser:
    def __init__(self):
        pass

    def process(self, data):
        try:
            d = json.loads(data)
        except json.decoder.JSONDecodeError:
            return
        try:
            purchase_time = datetime.strptime(d['purchase_time'], "%Y-%m-%dT%H:%M:%S.%f")
            expiration_time = datetime.strptime(d['expiration_time'], "%Y-%m-%d")
        except ValueError:
            return

        yield (d['txid'], d['rfid'], d['resort'], purchase_time, expiration_time, d['days'], d['name'], d['address'], d['phone'], d['email'], d['emergency_contact'])

    def end_partition(self):
        pass
$$;

-- This funtion returns only the valid data in the table.
-- Test that it is working as intended from the source table


SELECT * FROM INGESTED_DATA;
SELECT t.* FROM INGESTED_DATA, TABLE(TRY_PARSE_TICKET(RECORD_CONTENT)) as t;

-- It is desired to merge this schematized data into the destination table 
-- LIFT_TICKETS based on the RFID.
-- Create a stored procedure to perform the merge tickets from the INGESTED_DATA 
-- into LIFT_TICKETS using TRY_PARSE_TICKET and then truncate INGESTED_DATA when
--  complete. The key to perform the merge on is the TXID. This is done in a 
--  transaction so this would be a good pattern even for continuous data ingest.

CREATE OR REPLACE PROCEDURE TRANSFORM_TICKETS()
RETURNS VARCHAR
AS
BEGIN
    BEGIN TRANSACTION;
    MERGE INTO LIFT_TICKETS USING (
    SELECT t.* FROM INGESTED_DATA, TABLE(TRY_PARSE_TICKET(RECORD_CONTENT)) as t
    ) AS 
    DATA_IN ON DATA_IN.TXID = LIFT_TICKETS.TXID
    WHEN MATCHED THEN UPDATE SET 
        LIFT_TICKETS.RFID = DATA_IN.RFID, 
        LIFT_TICKETS.RESORT = DATA_IN.RESORT, 
        LIFT_TICKETS.PURCHASE_TIME = DATA_IN.PURCHASE_TIME, 
        LIFT_TICKETS.EXPIRATION_TIME = DATA_IN.EXPIRATION_TIME, 
        LIFT_TICKETS.DAYS = DATA_IN.DAYS, 
        LIFT_TICKETS.NAME = DATA_IN.NAME,
        LIFT_TICKETS.ADDRESS = DATA_IN.ADDRESS, 
        LIFT_TICKETS.PHONE = DATA_IN.PHONE, 
        LIFT_TICKETS.EMAIL = DATA_IN.EMAIL, 
        LIFT_TICKETS.EMERGENCY_CONTACT = DATA_IN.EMERGENCY_CONTACT
    WHEN NOT MATCHED THEN INSERT (TXID,RFID,RESORT,PURCHASE_TIME,EXPIRATION_TIME,DAYS,NAME,ADDRESS,PHONE,EMAIL,EMERGENCY_CONTACT) 
    VALUES (DATA_IN.TXID,DATA_IN.RFID,DATA_IN.RESORT,DATA_IN.PURCHASE_TIME,DATA_IN.EXPIRATION_TIME,DATA_IN.DAYS,DATA_IN.NAME,DATA_IN.ADDRESS,DATA_IN.PHONE,DATA_IN.EMAIL,DATA_IN.EMERGENCY_CONTACT);
    TRUNCATE TABLE INGESTED_DATA;
    COMMIT;
    RETURN 'ok';
END;

CALL TRANSFORM_TICKETS();
SELECT COUNT(*) FROM LIFT_TICKETS;
SELECT COUNT(*) FROM INGESTED_DATA;