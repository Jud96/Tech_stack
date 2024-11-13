
1. **data model** is a conceptual representation of data objects, the associations between different data objects, and the rules.
2. **OLTP** (Online Transaction Processing) is a class of software programs capable of supporting transaction-oriented applications on the Internet.
   1. OLTP is characterized by a large number of short online transactions (INSERT, UPDATE, DELETE).
   2. OLTP maintains a database that is an accurate model of some real-world enterprise.
   3. OLTP is used for data entry and data retrieval.
3. **Normalization** is the process of organizing data in a database. This includes creating tables and establishing relationships between those tables according to rules designed both to protect the data and to make the database more flexible by eliminating redundancy and inconsistent dependency.
   1. **1NF** : atomic values
   2. **2NF** : 1NF + no partial dependencies
   3. **3NF** : 2NF + no transitive dependencies
4. disavantages of normalization is that it can lead to a large number of tables and complex queries to retrieve data.
5. denormalization is the process of trying to improve the read performance of a database, at the expense of some write performance, by adding redundant copies of data or by grouping data.
6. **OLAP** (Online Analytical Processing) is a category of software that allows users to analyze information from multiple database systems at the same time.
7. **data warehouse** : a large store of data accumulated from a wide range of sources within a company and used to guide management decisions.
8. **data mart** is a subset of a data warehouse that is designed for a particular business line or team.
9.  **ETL** (Extract, Transform, Load) is a process in data warehousing responsible for pulling data out of the source systems and placing it into a data warehouse.
10. **ELT** (Extract, Load, Transform) is a process in data warehousing responsible for pulling data out of the source systems, placing it into a data warehouse, and then performing the transformation process.
    1.  **Extract**: Data is extracted from the source systems.
    2.  **Load**: Data is loaded into the data warehouse.
    3.  **Transform**: Data is transformed into a format that is suitable for analysis.
    4.  **ETL vs. ELT**: ETL is more traditional and involves transforming data before loading it into the data warehouse, while ELT loads the data first and then transforms it.
    5.  **ETL Tools**: Informatica, Talend, SSIS, DataStage, etc.
    6.  **ELT Tools**: Amazon Redshift, Google BigQuery, Snowflake, etc.
    7.  **ETL/ELT Process**: Extract data from source systems -> Load data into staging area -> Transform data into data warehouse format -> Load data into data warehouse.
    8.  **ETL/ELT Challenges**: Data quality, data integration, data transformation, data loading, data latency, data volume, data security, etc.
    9.  **ETL/ELT Best Practices**: Data profiling, data cleansing, data validation, data transformation, data loading, data monitoring, etc.
    10. **ETL/ELT Benefits**: Improved data quality, data integration, data consistency, data availability, data accuracy, data analysis, etc.
    11. **ETL/ELT Use Cases**: Data migration, data integration, data warehousing, data analytics, data reporting, etc.
11. **star schema** is the simplest style of data mart schema and is the approach most widely used to develop data warehouses and dimensional data marts. The star schema consists of one or more fact tables referencing any number of dimension tables.
    1.  **fact table** is a table that contains the measurements of a business process.
    2.  **dimension table** is a table that contains the descriptive attributes related to the fact data.
12. **snowflake schema** is a logical arrangement of tables in a multidimensional database such that the entity relationship diagram resembles a snowflake in shape.
    1.  snowflake schema is a more complex data warehouse model than a star schema, and is a type of star schema.
    2.  snowflake schema is a more normalized form of a star schema: the dimension tables are normalized which splits data into additional tables.
13. **data vault** is a system of business intelligence that is designed to provide long-term historical storage of data coming in from multiple operational systems.
    1.  agile stepwise evolving early value
    2.  trace what happened when
    3.  automation productivity reduce code base to reduce MI team size
    4.  to add some real time feeds 
    5.  to experiment,scrub and replace 
    6.  architecture flow is source (DL) -> stage -> raw -> business vault -> data mart
    7.  data vault is a detail-oriented, historical tracking and uniquely linked set of normalized tables that support one or more functional areas of business.
    8.  data vault is a hybrid approach that combines the best of 3NF and star schema.
    9.  data vault is designed to be flexible, scalable, and adaptable to changing business needs.
    10. data vault is optimized for ETL processes and data warehouse loading.
    11. data vault is designed to handle large volumes of data and complex business rules.
    12. data vault is well-suited for data warehouses that require historical tracking and auditability.
    13. data vault is a good fit for organizations with rapidly changing data sources and business requirements.
    14. satellite tables are used to store descriptive attributes and historical data.
    15. link tables are used to model relationships between business entities.
    16. hub tables are used to store unique business keys.
    17. a good example to use data vault modelling when we have a lot of data and we want to make sure that we can easily add new data
     sources and new data points without having to re-architect our data warehouse.
    18. when we have new sources of customer data should we add them all to dimcustomer table
     or should we create a new table for each source of customer data?
14. one big table is a data model that combines all the data into a single table.
    1.  advantages of one big table include simplicity and ease of use.
    2.  disadvantages of one big table include lack of scalability and flexibility.
15. **data lake** is a centralized repository that allows you to store all your structured and unstructured data at any scale.
16. **lambda architecture** is a data processing architecture designed to handle massive quantities of data by taking advantage of both batch and stream processing methods.
    1.  lambda architecture attempts to balance latency, throughput, and fault-tolerance by using batch processing to provide comprehensive and accurate views of batch data, while simultaneously using real-time stream processing to provide views of online data.
    2.  lambda architecture is well-suited for handling large-scale data processing tasks that require both batch and real-time processing.
    3.  lambda architecture is designed to provide a unified view of data across batch and real-time processing layers.
    4.  lambda architecture is a flexible and scalable approach to data processing that can adapt to changing business requirements.
    5.  lambda architecture is commonly used in big data applications that require real-time analytics and insights.
    6.  lambda architecture can help organizations improve their data processing efficiency and reduce the time-to-insight for critical business decisions.
17. **differences between Data Vault and Dimensional Modeling**
    1.  **Modeling Approach**: Data Vault separates structural information from descriptive attributes 
    (Hubs, Links, and Satellites), while Dimensional Modeling combines them
     in Fact and Dimension tables.
    2.  **Flexibility**: Data Vault is more flexible and adaptable to changing business
         requirements, due to its decentralized structure. Dimensional Modeling, 
         with its tightly-coupled schema design, may require more rework when changes occur.
    3.  **Scalability**: Data Vault is designed for large-scale enterprise data warehouses, providing better scalability and parallel loading capabilities. Dimensional Modeling is more suitable for smaller-scale data marts focused on specific business areas.
    4.  **Historical Data**: Data Vault inherently supports historical data tracking, while Dimensional Modeling requires the implementation of slowly changing dimensions to track changes over time.
18. Slowly changing dimension
    1. **Type 0**: Fixed Dimension
    2. **Type 1**: Overwrite
    3. **Type 2**: Add new row
    4. **Type 3**: Add new column (previous value , current value)
19. Data Load Strategies
    1. **Full Load**: All data is loaded from source to target, replacing existing data.
    2. **Incremental Load**: Only new or changed data is loaded from source to target, updating existing data.
    3. **Delta Load**: Only the changes (deltas) between the source and target data are loaded, reducing processing time and resource usage. 
 20. Activity schema is a data model that represents the relationships between activities and users.
 21. Entity-Centric Modelling is a data model that focuses on the entities and their relationships in a system.
 22. Kimball's Bus Architecture is a data warehousing architecture that organizes data marts around a central data warehouse, providing a common set of dimensions and facts for reporting and analysis.
     1.  **Bus Matrix**: A visual representation of the data warehouse architecture, showing the relationships between data marts and the shared dimensions and facts.
     2.  **Conformed Dimensions**: Dimensions that are shared across multiple data marts, ensuring consistency and accuracy in reporting.
     3.  data workflow
         1.  Data is moved to staging area
         2.  Data is scrubbed and made consistent
         3.  From Staging Data Marts are created
         4.  Data Marts are based on a single process
         5.  Sum of the data marts can constitute an Enterprise Data Warehouse
         6.  Conformed dimensions are the key to success
20. Independent Data Marts is a data warehousing architecture that allows each department or business unit to design and implement its own data mart independently.
21. **Data Warehouse vs. Data Mart**:
    1.  **Data Warehouse**:
        1.  **Scope**: Application independent, centralized or enterprise, planned
        2.  **Data**: Historical, detailed, summary, some denormalization
        3.  **Subjects**: Multiple subjects
        4.  **Source**: Many internal and external sources
        5.  **Other**: Flexible, data-oriented, long life, single complex structure
        6.  **Purpose**: Supports enterprise-wide reporting and analysis
    2. **Data Mart**:
        1.  **Scope**: Specific application, decentralized by group, organic but may be planned
        2.  **Data**: Some history, detailed, summary, high denormalization
        3.  **Subjects**: Single central subject area
        4.  **Source**: Few internal and external sources
        5.  **Other**: Restrictive, project-oriented, short life, multiple simple structures
        6.  **Purpose**: Supports departmental or business unit reporting and analysis

22. Kimbell vs Inmon vs Data Vault
| Aspect | Kimball | Inmon | Data Vault |
| --- | --- | --- | --- |
| Focus | Data marts | Data warehouse | Data warehouse |
| Architecture | Bottom-up | Top-down | Hybrid |
| Development | Quick, iterative | Long, structured | Flexible, scalable |
| Data Model | Star schema | 3NF | Hub, Link, Satellite |
| Flexibility | More flexible | Less flexible | Highly flexible |
| User Involvement | High | Low | High |
| Data Quality | Acceptable | High | High |
| Data Governance | Less formal | Formal | Formal |
| Data Integration | Easier | Complex | Easier |
| Scalability | Limited | High | High |
| Historical Data | Limited | High | High |
| Implementation | Departmental | Enterprise-wide | Enterprise-wide |
| Business Requirements | Focus on business needs | Focus on data | Focus on data and business needs |
| Data Storage | Data marts | Data warehouse | Data warehouse |
| Data Loading | Batch | Batch | Batch and real-time |
| Data Access | Query-based | Query-based | Query-based and self-service |
|timeframe| slowly changing | continouns & Discrete | continouns & Discrete |
|timeframe method | dimensions key | timestamp | timestamp |



