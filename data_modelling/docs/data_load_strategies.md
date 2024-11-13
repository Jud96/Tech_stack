### data load strategies
Data loading strategies

In our data warehouse, data lake, and data lake house we can have various load strategies like:

Full Load: The full load strategy involves loading all data from source systems into the data warehouse. This strategy is typically used in the case of performance issues or lack of columns that could inform about row modification.

Incremental Load: The incremental load strategy involves loading only new data since the last data load. If rows in the source system can’t be changed, we can load only new records based on a unique identifier or creation date. We need to define a “watermark” that we will use to select new rows.

Delta Load: The delta load strategy focuses on loading only the changed and new records since the last load. It differs from incremental load in that it specifically targets the delta changes rather than all records. Delta load strategies can be efficient when dealing with high volumes of data changes and significantly reduce the processing time and resources required.

[&laquo; Previous](SCD.md) [Next &raquo;](Data_vault.md)