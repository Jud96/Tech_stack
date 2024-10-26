from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col
from pyspark.sql.types import StructType, StringType, DoubleType, LongType

# Create a Spark session
spark = SparkSession.builder \
    .appName("KafkaStructuredStreaming") \
    .config("spark.streaming.stopGracefullyOnShutdown", "true") \
    .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2") \
    .getOrCreate()

# Define the Kafka stream using Structured Streaming
df = spark.readStream.format("kafka") \
    .option("kafka.bootstrap.servers", "localhost:9092") \
    .option("subscribe", "currency_rates") \
    .option("startingOffsets", "earliest") \
    .load()


df.printSchema()
# Define the schema for the value column (assuming the message is in JSON format)
schema = StructType() \
    .add("ccy_couple", StringType()) \
    .add("rate", DoubleType()) \
    .add("event_time", LongType())  # Assuming event_time is in epoch format


# Select the key and value from Kafka as strings and deserialize the JSON value
df = df.selectExpr("CAST(value AS STRING) as json_string") \
    .select(from_json(col("json_string"), schema).alias("data")) \
    .select("data.*")  # Extract fields from the JSON data

# # Group by currency pair (ccy_couple) and calculate the mean rate
agg_df = df.groupBy("ccy_couple").agg({"rate": "mean"})

# # Write the result to the console for testing
query = agg_df.writeStream \
    .outputMode("update") \
    .format("console") \
    .start()

query.awaitTermination()