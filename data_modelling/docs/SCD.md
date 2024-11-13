### SCD 
Slowly changing dimension

A Slowly Changing Dimension (SCD) is a concept in dimensional modeling. It handles changes to dimension attributes over time in dimension tables. SCD provides a mechanism for maintaining historical and current data within a dimension table as business entities evolve and their attributes change. There are six types of SCD, but the three most popular ones are:

SCD Type 0: In this type, only new records are imported into dimension tables without any updates. <br>
SCD Type 1: In this type, new records are imported into dimension tables, and existing records are updated. <br>
SCD Type 2: In this type, new records are imported, and new records with new values are created for changed attributes. <br>
SCD Type 3: In this type, new records are imported, and new columns are added to the dimension table to store the previous value of the changed attribute. <br>

[&laquo; Previous](OLAP_Cubes.md) [Next &raquo;](data_load_strategies.md)