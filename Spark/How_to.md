## notes

1. Spark is a distributed computing framework that provides an interface for programming entire clusters with implicit data parallelism and fault tolerance.
   1. Spark is built on the concept of Resilient Distributed Datasets (RDDs), which are immutable distributed collections of objects. 
   2.  Spark is designed to be fast and general-purpose, with APIs in Scala, Java, Python, and R.
   3.  used for a wide range of applications, including batch processing, real-time stream processing, machine learning, and graph processing.
2.  how spark works
    1.  spark context is the main entry point for spark functionality. It represents the connection to a spark cluster and can be used to create RDDs, accumulators, and broadcast variables.
    2.  YARN is a resource manager that allocates resources across applications running on a cluster. It is used by spark to manage resources and schedule tasks.
    3.  spark executors are processes that run on worker nodes in a spark cluster. They execute tasks and store data in memory or on disk.
    4.  spark driver is the process that runs the main function of a spark application and creates the spark context. It coordinates the execution of tasks on the executors and collects the results.
    5.  The nodes read and write data from and to the file system and cache transformed data in-memory as *Resilient Distributed Datasets* (RDDs)
3. Hadoop is highly fault-tolerant distributed file system and, like Hadoop in general, designed to be deployed on low-cost hardware. It provides high throughput access to application data and is suitable for applications that have large data sets.
   1. RDD (Resilient Distributed Dataset) is a fundamental data structure of Spark. It is an immutable distributed collection of objects. Each dataset in RDD is divided into logical partitions, which may be computed on different nodes of the cluster. RDDs can contain any type of Python, Java, or Scala objects, including user-defined classes.
4. parquet is columnar storage format, which is more efficient than row-based storage formats like CSV or JSON. and it is best for analytics workloads. Avro is a row-based storage format, which is more efficient for time-series data that is frequently updated or appended to.
5. broadcast variables are read-only shared variables that are cached and available on all nodes in a spark cluster. They are useful for efficiently distributing large read-only datasets to all nodes in a spark application.


## core Functions

|Function	|Description|	Example|
|---|---|---|
| parallelize()	|Create a DataFrame from an RDD.	|spark.parallelize([(1, "Alice"), (2, "Bob")]).toDF(["id", "name"])|
| getNumPartitions()	|Get the number of partitions in an RDD.	|rdd.getNumPartitions()|
| repartition()	|Change the number of partitions in an RDD.	|rdd.repartition(4)|
| count()	|Count the number of elements in an RDD.	|rdd.count()|
| countByKey()	|Count the number of elements for each key.	|rdd.countByKey()|
| countByValue()	|Count the number of occurrences for each value.	|rdd.countByValue()|
| collectAsMap()	|Return the key-value pairs in the RDD as a dictionary.	|rdd.collectAsMap()|
| map()	|Apply a function to each element in the RDD.	|rdd.map(lambda x: x + 1)|
| flatMap()	|Apply a function that returns an iterator to each element.	|rdd.flatMap(lambda x: (x, x + 1))|
| filter()	|Filter elements based on a condition.	|rdd.filter(lambda x: x > 0)|
| max()	|Find the maximum value in the RDD.	|rdd.max()|
| min()	|Find the minimum value in the RDD.	|rdd.min()|
| mean()	|Calculate the mean of the elements in the RDD.	|rdd.mean()|
| sum()	|Calculate the sum of the elements in the RDD.	|rdd.sum()|
| reduce()	|Aggregate the elements of the RDD using a function.	|rdd.reduce(lambda x, y: x + y)|
|variance()	|Calculate the variance of the elements in the RDD.	|rdd.variance()|
|stdev()	|Calculate the standard deviation of the elements in the RDD.	|rdd.stdev()|
| union()	|Combine two RDDs.	|rdd1.union(rdd2)|
| collect()	|Return all the elements in the RDD as a list.	|rdd.collect()|
| take()	|Return the first n elements of the RDD.	|rdd.take(5)|
| first()	|Return the first element of the RDD.	|rdd.first()|
| top()	|Return the top n elements of the RDD.	|rdd.top(5)|
| distinct()	|Return a new RDD with distinct elements.	|rdd.distinct()|
| reduceByKey()	|Combine values with the same key using a function.	|rdd.reduceByKey(lambda x, y: x + y)|
| groupByKey()	|Group values with the same key.	|rdd.groupByKey()|
| sortByKey()	|Sort the RDD by key.	|rdd.sortByKey()|
| coalesce()	|Reduce the number of partitions in an RDD.	|rdd.coalesce(2)|
|read()	|Read data from a source.	|spark.read.csv("file.csv")|
|write()	|Write data to a destination.	|df.write.csv("file.csv")|
|printSchema()	|Print the schema of the DataFrame.	|df.printSchema()|
|count()	|Count the number of rows in the DataFrame.	|df.count()|
|describe()	|Generate descriptive statistics of the DataFrame.	|df.describe()|
|select()	|Select specific columns from the DataFrame.	|df.select("column1", "column2")|
|filter()	|Filter rows based on a condition.	|df.filter(df["column"] > value)|
|withColumn()	|Add or modify a column in the DataFrame.	|df.withColumn("new_column", expression)|
|groupBy()	|Group data by specific columns.	|df.groupBy("column").agg({"column": "function"})|
|orderBy()	|Sort the DataFrame by one or more columns.	|df.orderBy(df["column"].desc())|
|show()	|Display the DataFrame content in tabular format.	|df.show()|
|agg()	|Perform aggregate functions like sum, avg.	|df.groupBy("column").agg({"column": "avg"})|
|alias()	|Rename a column.	|df.select(df["column"].alias("new_column"))|
|drop()	|Remove a column from the DataFrame.	|df.drop("column")|
|distinct()	|Return a new DataFrame with distinct rows.	|df.distinct()|
|dropDuplicates()	|Remove duplicate rows based on selected columns.	|df.dropDuplicates(["column1", "column2"])|
|dropna()	|Remove rows with null values.	|df.dropna()|
|join()	|Join two DataFrames based on a condition.	|df1.join(df2, df1["id"] == df2["id"], "inner")|
|union()	|Combine two DataFrames with the same schema.	|df1.union(df2)|
|limit()	|Return the first n rows of the DataFrame.	|df.limit(10)|
|fillna()	|Replace null values with specified values.	|df.fillna({"column": value})|
|replace()	|Replace values in a DataFrame.	|df.replace("old_value", "new_value", "column")|
|sample()	|Return a random sample of the DataFrame.	|df.sample(withReplacement=False, fraction=0.1)|
|collect()	|Return all the rows as a list of Row objects.	|df.collect()|
|rdd	|Convert a DataFrame into an RDD (Resilient Distributed Dataset).	|df.rdd|
|cache()	|Cache the DataFrame in memory.	|df.cache()|
|unpersist()	|Remove the DataFrame from memory or disk.	|df.unpersist()|
|withColumnRenamed()	|Rename an existing column.	|df.withColumnRenamed("old_name", "new_name")|
|sort()	|Sort by one or more columns (alias for orderBy).	|df.sort(df["column"].asc())|
|isNull()	|Check if a column value is null.	|df.filter(df["column"].isNull())|
|isNotNull()	|Check if a column value is not null.	|df.filter(df["column"].isNotNull())|
|crossJoin()	|Perform a cross join between two DataFrames.	|df1.crossJoin(df2)|
|todate()	|Convert a string to a date.	|df.withColumn("date", to_date("date", "yyyy-MM-dd"))|
|todatetime()	|Convert a string to a timestamp.	|df.withColumn("timestamp", to_timestamp("timestamp", "yyyy-MM-dd HH:mm:ss"))|
|datediff()	|Calculate the difference between two dates.	|df.withColumn("days_diff", datediff("date1", "date2"))|
|date_format()	|Format a date column.	|df.withColumn("formatted_date", date_format("date", "yyyy-MM-dd"))|
|topandas()	|Convert a Spark DataFrame to a Pandas DataFrame.	|df.toPandas()|
|cast()	|Convert a column to a different data type.	|df.withColumn("new_column", df["column"].cast(IntegerType()))|
|F    |Access functions in the pyspark.sql.functions module.	|df.withColumn("new_column", F.col("column"))|
|percentile|Calculate the percentile of a column.	|df.withColumn("percentile", F.expr("percentile(column, 0.5)"))|d
|countDistinct()	|Count the number of distinct values in a column.	|df.agg(F.countDistinct("column"))|
|window   |Define a window specification for window functions.	|windowSpec = Window.partitionBy("column1").orderBy("column2")|
|lead()	|Get the value of the next row in a window.	|df.withColumn("next_value", F.lead("column", 1).over(windowSpec))|
|dense_rank()	|Assign a rank to rows in a window without gaps.	|df.withColumn("rank", F.dense_rank().over(windowSpec))|
|row_number()	|Assign a unique row number to rows in a window.	|df.withColumn("row_number", F.row_number().over(windowSpec))|
|udf()	|Create a user-defined function (UDF).	|udf_func = F.udf(lambda x: x + 1, IntegerType())|
|when()	|Apply a condition to a column.	|df.withColumn("new_column", F.when(df["column"] > 0, 1).otherwise(0))|
|explode()	|Transform an array column into multiple rows.	|df.withColumn("exploded_column", F.explode("array_column"))|
|split()	|Split a string column into an array of strings.	|df.withColumn("split_column", F.split("string_column", ","))|
|array_contains()	|Check if an array column contains a specific value.	|df.withColumn("contains_value", F.array_contains("array_column", "value"))|
|createOrReplaceTempView()	|Create or replace a temporary view.	|df.createOrReplaceTempView("temp_view")|
|sql()	|Execute a SQL query on the DataFrame.	|spark.sql("SELECT * FROM temp_view")|
|broadcast()	|Broadcast a DataFrame to all nodes.	|df_broadcast = F.broadcast(df)|
|explain()	|Display the execution plan of a DataFrame.	|df.explain()|
|write.partitionBy()	|Partition the output data by specific columns.	|df.write.partitionBy("column1", "column2").csv("output")|
|selectExpr()	|Select columns using SQL expressions.	|df.selectExpr("column1", "column2 AS new_column")|


**using udf**
```python
from pyspark.sql.functions import udf
# Define a Python method
def reverseString (mystr) :
    return mystr[::-1]
    
# Wrap the function and store as a variable
udfReverseString = udf(reverseString, StringType ())
    
# Use with Spark
user_df = user_df.withColumn ('ReverseName',
udfReverseString (user_df.Name))
```

**using window function**
```python
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number
windowSpec = Window.partitionBy("department").orderBy("salary")
df.withColumn("row_number", row_number().over(windowSpec))
```

**using monotonically_increasing_id()**
```python
from pyspark.sql.functions import monotonically_increasing_id
df.withColumn("id", monotonically_increasing_id())
```

**Cache and unpersist**
```python
df.cache() # Cache the DataFrame in memory
df.is_cached # Check if the DataFrame is cached
df.unpersist() # Remove the DataFrame from memory
```

**wildcard character**
```python
df = spark.read.csv("*.csv", header=True, inferSchema=True)
```

**view the plan**
```python
df.explain() # Display the execution plan of the DataFrame
```

**broadcast**
```python
from pyspark.sql.functions import broadcast
df_broadcast = broadcast(df)
```

**list of tables**
```python
spark.catalog.listTables()
```