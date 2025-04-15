# AWS S3

AWS S3 is an object storage service that offers scalability, data availability, security, and performance.

## Types of Storage Classes

- **Standard**: General-purpose storage for frequently accessed data.
- **Intelligent-Tiering**: Automatically moves data to the most cost-effective access tier.
- **Standard-IA**: Infrequent access storage for data that is less frequently accessed.
- **One Zone-IA**: Lower-cost option for infrequently accessed data that does not require multiple availability zone resilience.
- **Glacier**: Low-cost storage for data archiving and long-term backup.
- **Glacier Deep Archive**: Lowest-cost storage for data archiving with retrieval times of 12 hours or more.
- **Reduced Redundancy Storage (RRS)**: Lower durability than standard storage, suitable for non-critical data.
- **S3 Outposts**: Delivers object storage to on-premises environments.

## S3 Features

- **Durability**: 99.999999999% (11 9's) durability.
- **Availability**: 99.99% availability.
- **Scalability**: Automatically scales to meet demand.
- **Security**: Supports encryption at rest and in transit, IAM policies, bucket policies, and ACLs.
- **Versioning**: Keeps multiple versions of an object in the same bucket.
- **Lifecycle Policies**: Automate the transition of objects to different storage classes or deletion after a specified period.
- **Cross-Region Replication**: Automatically replicates objects across different AWS regions.
- **Event Notifications**: Triggers notifications for events like object creation, deletion, or restoration.
- **Data Transfer Acceleration**: Speeds up uploads and downloads using Amazon CloudFront's globally distributed edge locations.
- **Transfer Family**: Managed file transfer service for SFTP, FTPS, and FTP.
- **S3 Select**: Allows querying of data in S3 using SQL-like syntax.
- **S3 Inventory**: Provides a scheduled report of objects and their metadata in a bucket.
- **S3 Batch Operations**: Enables bulk operations on large numbers of objects.
- **S3 Object Lambda**: Allows modification of data returned by S3 GET requests.
- **S3 Access Points**: Simplifies managing data access at scale for shared datasets.
- **S3 Object Lock**: Protects objects from being deleted or overwritten for a specified period.
- **S3 Storage Lens**: Provides visibility into object storage usage and activity trends.
- **S3 Access Analyzer**: Helps identify and remediate unintended access to S3 buckets.
- **S3 Replication Time Control**: Provides predictable replication times for cross-region replication.
- **S3 Multi-Region Access Points**: Simplifies data access across multiple AWS regions.

## S3 Pricing

- **Storage Costs**: Charged based on the amount of data stored in S3.
- **Data Transfer Costs**: Charged for data transferred out of S3 to the internet or other AWS regions.
- **Request Costs**: Charged for requests made to S3, including PUT, GET, LIST, and DELETE requests.
- **Data Retrieval Costs**: Charged for retrieving data from Glacier and other storage classes.
- **Data Lifecycle Management Costs**: Charged for using lifecycle policies to transition or delete objects.
- **Data Transfer Acceleration Costs**: Charged for using the data transfer acceleration feature.
- **S3 Select and Glacier Select Costs**: Charged for using S3 Select and Glacier Select to retrieve a subset of data.

## S3 Best Practices

- **Use Versioning**: Enable versioning to protect against accidental deletions or overwrites.
- **Implement Lifecycle Policies**: Use lifecycle policies to automatically transition objects to lower-cost storage classes or delete them after a specified period.
- **Use Encryption**: Enable server-side encryption for data at rest and use HTTPS for data in transit.
- **Monitor Usage**: Use S3 Storage Lens and CloudWatch metrics to monitor storage usage and access patterns.
- **Optimize Data Transfer**: Use S3 Transfer Acceleration for faster uploads and downloads, especially for large files.
- **Use Multipart Uploads**: For large objects, use multipart uploads to improve upload performance and reliability.
- **Implement Access Controls**: Use IAM policies, bucket policies, and ACLs to control access to S3 buckets and objects.
- **Use Cross-Region Replication**: For disaster recovery and data redundancy, use cross-region replication to replicate objects across different AWS regions.
- **Regularly Review Permissions**: Periodically review and audit permissions to ensure that only authorized users have access to S3 resources.
- **Use S3 Inventory**: Use S3 Inventory to generate reports on objects and their metadata for auditing and compliance purposes.
- **Test Data Retrieval**: Regularly test data retrieval from Glacier and other storage classes to ensure that data can be accessed when needed.
- **Use S3 Access Analyzer**: Use S3 Access Analyzer to identify and remediate unintended access to S3 buckets.
- **Optimize Object Size**: Use appropriate object sizes to optimize performance and reduce costs.
- **Use S3 Object Lock**: Use S3 Object Lock to protect objects from being deleted or overwritten for a specified period.
- **Use S3 Batch Operations**: Use S3 Batch Operations for bulk operations on large numbers of objects.
- **Use S3 Access Points**: Use S3 Access Points to simplify managing data access at scale for shared datasets.
- **Use S3 Object Lambda**: Use S3 Object Lambda to modify data returned by S3 GET requests.
- **Use S3 Storage Lens**: Use S3 Storage Lens to gain visibility into object storage usage and activity trends.

## S3 Monitoring and Logging
- **CloudWatch Metrics**: Monitor S3 bucket metrics such as number of objects, total size, and request counts using CloudWatch.
- **CloudTrail Logs**: Enable AWS CloudTrail to log API calls made to S3 for auditing and compliance.
- **S3 Server Access Logs**: Enable server access logging to track requests made to S3 buckets.
- **S3 Event Notifications**: Set up event notifications to trigger actions based on specific events, such as object creation or deletion.
- **S3 Storage Lens**: Use S3 Storage Lens to gain insights into storage usage and activity trends across multiple buckets.
- **S3 Inventory Reports**: Use S3 Inventory to generate scheduled reports of objects and their metadata in a bucket.
- **S3 Access Analyzer**: Use S3 Access Analyzer to identify and remediate unintended access to S3 buckets.
- **S3 Metrics and Alarms**: Set up CloudWatch alarms based on S3 metrics to monitor for unusual activity or performance issues.
- **S3 Data Events**: Use CloudTrail data events to log object-level API activity for S3 buckets.


## S3 Security Best Practices
- **Use IAM Policies**: Implement fine-grained access control using IAM policies to restrict access to S3 resources.
- **Enable Bucket Policies**: Use bucket policies to control access to S3 buckets and objects.
- **Use ACLs**: Use Access Control Lists (ACLs) to manage permissions for individual objects in S3.
- **Enable Server-Side Encryption**: Use server-side encryption to protect data at rest in S3.
- **Use HTTPS**: Always use HTTPS for data in transit to protect data from interception.
- **Enable MFA Delete**: Use Multi-Factor Authentication (MFA) Delete to add an extra layer of security for deleting objects.
- **Implement Object Lock**: Use S3 Object Lock to prevent objects from being deleted or overwritten for a specified period.
- **Use VPC Endpoints**: Use VPC endpoints to securely connect to S3 without traversing the public internet.
- **Regularly Review Permissions**: Periodically review and audit permissions to ensure that only authorized users have access to S3 resources.




