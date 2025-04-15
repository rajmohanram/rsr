# AWD RDS

Managed Relational Database services (RDS) is a service that provides a fully managed relational database in the cloud. It is designed to simplify the setup, operation, and scaling of relational databases in the cloud.

## Pros

- Provisioning & Underlying OS patching
- Automated backups
- Monitoring and dashboards
- Scaling, storage autoscaling
- Multi-AZ, High availability
- Security, Encryption
- Replication, Read replicas
- Snapshots, Performance tuning


## DB engines

Following are the supported database engines:

- Amazon RDS for SQL Server, which is a managed version of Microsoft SQL Server
- Amazon RDS for MySQL, which is a managed version of MySQL
- Amazon RDS for MariaDB, which is a managed version of MariaDB
- Amazon RDS for PostgreSQL, which is a managed version of PostgreSQL
- Amazon RDS for Oracle, which is a managed version of Oracle
- Amazon RDS for Amazon Aurora, which is a managed version of Amazon Aurora (proprietary to AWS)
  - MySQL-compatible edition
  - PostgreSQL-compatible edition
  - Features and benefits


## MySQL setup

- MySQL version: 5.6, 5.7, 8.0
- Templates:
  - Production (24/7 availability, multi-AZ, backup retention period of 35 days, 1 hour of backup window, 1 hour of maintenance window)
  - Dev/Test (non-production, single-AZ, backup retention period of 1 day)
  - Free tier (limited to 20 GB of storage, 1 vCPU, 1 GB of RAM, and 20 GB of backup storage)
- Availability and durability:
  - Single DB instance (single DB instance in an AZ with no standby for failover)
  - Multi-AZ DB instance (single DB instance in an AZ with a standby instance in another AZ for failover. Standby instance is not accessible to the user)
  - Multi-AZ DB cluster (Primary DB instance in an AZ with two readable standby instances in other AZs for failover. Standby instances are accessible to the user)
- Instance class: db.t3, db.t4g, db.m5, db.m6g, db.r5, db.r6g

## Storage autoscaling

Storage autoscaling is a feature of Amazon RDS that automatically increases the storage capacity of your database instance when it reaches a certain threshold. This allows you to avoid running out of storage space and ensures that your database can continue to operate without interruption.
Storage autoscaling is available for Amazon RDS for MySQL, Amazon RDS for PostgreSQL, Amazon RDS for MariaDB, and Amazon RDS for Oracle. It is not available for Amazon RDS for SQL Server or Amazon RDS for Amazon Aurora.
Storage autoscaling is enabled by default for new database instances, but you can disable it if you prefer. You can also manually increase the storage capacity of your database instance at any time.
When storage autoscaling is enabled, Amazon RDS monitors the storage usage of your database instance and automatically increases the storage capacity when it reaches a certain threshold. The threshold is based on the average storage usage over a period of time, and it is designed to ensure that your database has enough storage space to operate without interruption.

Threshold configurations are as follows:
Maximum storage threshold: It is the maximum storage threshold for the database instance. The default value is 64 TB.

## Read replicas

Read replicas are a feature of Amazon RDS that allows you to create one or more copies of your database instance in different availability zones. This allows you to offload read traffic from your primary database instance and improve the performance of your application.
Asynchronous replication is used to replicate data from the primary database instance to the read replicas. This means that there may be a slight delay between when data is written to the primary database instance and when it is available on the read replicas. Eventually consistent reads are supported on read replicas, which means that you can read data from the read replicas even if it is not yet available on the primary database instance.
