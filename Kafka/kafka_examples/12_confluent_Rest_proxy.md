## confluent Rest proxy

Kafka REST Proxy is a RESTful interface to a Kafka cluster. It allows you to produce and consume messages, view the state of the cluster, and perform administrative actions without using the native Kafka protocol or clients. This is useful for developing applications that require access to Kafka, but do not want to use the native Kafka protocol.

```bash
#docker-compose.yml
version: '2'
services:
  rest-proxy:
    image: confluentinc/cp-kafka-rest:5.0.0
    hostname: rest-proxy
    container_name: rest-proxy
    ports:
      - "8082:8082"
    environment:
      KAFKA_REST_HOST_NAME: rest-proxy
      KAFKA_REST_BOOTSTRAP_SERVERS: kafka:9092
      KAFKA_REST_LISTENERS: http://localhost:8082
    KAFKA_REST_SCHEMA_REGISTRY_URL: http://schema-registry:8081
    depends_on:
      - kafka
      - schema-registry
```

```bash
# get the list of topics
curl -X GET http://localhost:8082/topics
```

```bash
# create a topic
curl -X POST -H "Content-Type: application/vnd.kafka.v2+json" \
  --data '{"topic": "my_topic", "partitions": 1, "replicas": 1}' \
  http://localhost:8082/topics
```

```bash
# produce a message
curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
  --data '{"records": [{"value": {"foo": "bar"}}]}' \
  http://localhost:8082/topics/my_topic
```
