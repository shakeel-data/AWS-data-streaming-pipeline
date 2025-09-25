# 🛢️ End-to-End AWS Data Streaming Pipeline Project | Apache Kafa + RDS + S3
<img width="1221" height="447" alt="image" src="https://github.com/user-attachments/assets/9c5cf060-45bb-4a56-a93c-1e4c3ba82da7" />

A Data Streaming Pipeline in **AWS** enables the real-time processing and movement of data from sources like databases, applications, or IoT devices to storage or analytics systems. It ensures low-latency data flow, supports scalable ingestion with services like **Kafka (MSK)** and processing with **AWS Glue, Kinesis, or Spark.** This is crucial for **real-time analytics, monitoring, fraud detection, and event-driven applications**, helping businesses make faster and more accurate decisions.

## 📘 Project Overview
This project demonstrates how to build a real-time data streaming pipeline using Apache Kafka and AWS managed services. It captures real-time changes from a Microsoft SQL Server database hosted on Amazon RDS, streams the data through **AWS MSK (Managed Streaming for Apache Kafka)** using Debezium's MSSQL source connector, and delivers the processed data to Amazon S3 using an S3 Sink Connector. By implementing **Change Data Capture (CDC)**, the pipeline ensures that every insert, update, or delete in the source database is continuously streamed and stored in S3, making it ideal for **real-time analytics, data lakes, or downstream processing**.

This project highlights practical skills in setting up **MSK clusters, managing IAM roles, configuring Kafka connectors**, and ensuring secure and scalable data flow between services.
It serves as a hands-on example of architecting scalable, event-driven pipelines using fully managed services in the AWS ecosystem, **suitable for modern data engineering and streaming analytics applications.**

## 🎯 Key Objectives
- Apache Kafka involves topics where **producers write data and consumers read data.**
- Producers are applications writing data to **Kafka topics, and Consumers are applications reading data from topics.**
- Kafka Connect is a framework or service for connecting Kafka with **external systems like databases, key-value stores, search indexes, and file systems.**
- It simplifies integration by providing **pre-built, reusable connectors (plugins)** that handle the logic of getting data into or out of Kafka.
- **Install a plugin within Kafka Connect** and then create a connector instance from that plugin.
- There are two types of connectors:
  - **Source Connectors:** Produce data from source systems (like databases) into **Kafka topics**. They act like producers.
  - **Sync Connectors:** Consume data from Kafka topics and deliver it to destination systems **(like S3, Snowflake)**. They act like consumers

| **Connector Type** | **Function**                                 | **Direction (Relative to Kafka)** | **Example in Pipeline**       |
| ------------------ | -------------------------------------------- | --------------------------------- | ----------------------------- |
| Source             | Pulls data from a system into Kafka          | Inward                            | Debezium SQL Server Connector |
| Sink               | Pushes data from Kafka to an external system | Outward                           | Amazon S3 Sink Connector      |

## 🪜 Project Workflow
### 1. Setting up Source and Destination
- Create a SQL Server database on Amazon RDS.
- Create a sample table and enable CDC on it.
- Insert sample data into the table.
- Create an S3 bucket for the destination.
- Set up a VPC endpoint for S3 to allow the MSK Connect cluster (running in a VPC) to connect to S3 without public internet access.

### 2. Creating MSK Cluster and Kafka Topic
- Create a provisioned MSK cluster.
- Configure security groups to allow traffic from necessary sources (like your local machine for testing, and potentially the Kafka Connect cluster).
- Enable IAM role-based authentication for the cluster.
- A Kafka topic is needed for the data stream. The source connector can automatically create the topic if configured to do so, following a pattern like `database.schema.table`

### 3. Setting Up Connectors in MSK Connect
- Create an IAM role for the connectors with permissions to connect to the MSK cluster and access S3.
- Download the connector plugins (e.g., Debezium SQL Server, Amazon S3 Sink) as ZIP files.
- Upload the connector plugin ZIP files to an S3 bucket.
- In MSK Connect, create a customized plugin for each connector type by pointing to the ZIP file in S3.
- Create a Source connector instance using the Debezium plugin, specifying configuration details like RDS host, database credentials, tables to include, and the target MSK cluster/bootstrap servers.
- Associate the connector with the IAM role created earlier.
- Configure logging for the connector.
- Create a Sync connector instance using the S3 Sink plugin, specifying configuration details like the source Kafka topic name and the target S3 bucket name.
- Associate the Sync connector with the same IAM role and configure logging. 

### 4. Verification
- To verify data streaming, you can set up an EC2 instance, install Kafka clients, and consume messages directly from the Kafka topic created by the source connector.
- Attach an IAM role to the EC2 instance with permissions to consume from the MSK cluster.
- Verify data landing in the target S3 bucket. The S3 sync connector will write files to S3, typically organized by topic and partition.
- Make changes (e.g., delete a record) in the source database and observe the corresponding change records appearing in the S3 bucket in near real-time, confirming the pipeline is working. 

## 🌟 Highlights and Key Insights
- **End-to-End Real-Time Streaming:** Achieved near real-time data ingestion from an Amazon RDS SQL Server database to Amazon S3 using Apache Kafka and MSK Connect.
- **CDC Integration with Debezium:** Enabled Change Data Capture (CDC) on the source database, allowing the system to capture and stream only the change events (insert/update/delete) efficiently.
- **Fully Managed Kafka Architecture:** Leveraged AWS MSK and MSK Connect for managed Kafka and connector services, eliminating the need to manage Kafka infrastructure manually.
- **Secure and Scalable Design:** Ensured data flow through private subnets using VPC endpoints, IAM-based authentication, and fine-grained access controls for secure data movement.
- **Real-Time Verification and Monitoring:** Successfully verified streaming via Kafka consumer on EC2 and observed structured output in S3, confirming full pipeline functionality.

## ☁️ Tools and Technologies
- **Amazon RDS (SQL Server)** – For hosting the source transactional database with Change Data Capture (CDC) enabled.
- **Amazon S3** – Destination data lake to store the streamed data in structured formats.
- **Amazon MSK (Managed Streaming for Kafka)** – Fully managed Apache Kafka service to handle real-time data streaming.
- **MSK Connect** – For deploying Debezium Source Connector and S3 Sink Connector to move data between RDS and S3.
- **Apache Kafka** – Backbone of the streaming pipeline for reliable message brokering.
- **Debezium (SQL Server Source Connector)** – To capture change events (CDC) from the SQL Server database.
- **Amazon EC2** – Used to run Kafka CLI tools for consumer testing and verification.
- **IAM (Identity and Access Management)** – To assign roles and policies securely across services. 
- **VPC & VPC Endpoints** – For private, secure communication between services like MSK and S3 without internet access.
- **DBeaver** – SQL client for database management and table creation.

## ✅🔄 Conclusion & Next Steps
This project demonstrates the successful creation of a real-time data streaming pipeline using AWS services and open-source technologies like **Apache Kafka and Debezium.** We showcased how change data capture **(CDC)** events from a SQL Server database hosted on **Amazon RDS** can be captured and streamed into Amazon S3 through an Apache Kafka topic managed by Amazon MSK and MSK Connect. **This pipeline enables near real-time data ingestion, making it highly suitable for use cases like data lakes, analytics, reporting, or backup systems.** By decoupling the source **(RDS)** and the destination **(S3)**, it allows for **scalability, fault tolerance,** and **flexibility** in enterprise data architectures.
This helped build a strong understanding of how to **design, configure, and troubleshoot a cloud-native streaming architecture using AWS.**

### 📌 Key Takeaways:
- Gained **hands-on experience with Debezium Source and S3 Sink connectors**.
- Learned to handle secure role-based access using **IAM and networking via VPC endpoints**.
- Observed real-time data movement from **SQL Server to S3, validating end-to-end functionality.**

### 🚀 What’s Next:
- Add ETL/ELT logic using **AWS Glue, Kinesis, or Lambda** for real-time transformation.
- Query S3-stored data using **Amazon Athena** and visualize results with **QuickSight**.
- Explore schema **registry, error handling, and DLQs** (Dead Letter Queues) for production-grade pipelines.
