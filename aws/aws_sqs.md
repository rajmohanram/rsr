# AWS SQS

SQS is a fully managed message queuing service that enables you to decouple and scale microservices, distributed systems, and serverless applications. It allows you to send, store, and receive messages between software components at any volume without losing messages.


## SQS Queues

SQS queues are the main component of SQS. They are used to store messages that are sent from producers and consumed by consumers. There are two types of queues in SQS:

1. **Standard Queues**: These queues provide maximum throughput, best-effort ordering, and at-least-once delivery. They are suitable for most use cases where the order of messages is not critical.
2. **FIFO Queues**: These queues provide exactly-once processing and guaranteed ordering of messages. They are suitable for use cases where the order of messages is critical, such as financial transactions or inventory management.
3. **Dead Letter Queues (DLQ)**: These are special queues that are used to store messages that cannot be processed successfully after a certain number of attempts. DLQs help to isolate and troubleshoot problematic messages without affecting the main queue.
4. **FIFO DLQs**: These are special queues that are used to store messages that cannot be processed successfully after a certain number of attempts in FIFO queues. FIFO DLQs help to isolate and troubleshoot problematic messages without affecting the main FIFO queue.
5. **SQS Extended Client Library**: This library allows you to send and receive large messages (up to 2 GB) by storing the message payload in Amazon S3 and sending a reference to the S3 object in the SQS message. This is useful for applications that need to send large payloads without exceeding the SQS message size limit of 256 KB.
6. **SQS Message Attributes**: These are optional metadata that can be associated with SQS messages. They allow you to add additional information to messages without modifying the message body. Message attributes can be used for filtering, routing, and processing messages based on their attributes.
7. **SQS Message Groups**: These are used in FIFO queues to group related messages together. Messages within the same message group are processed in order, while messages in different message groups can be processed concurrently. This allows you to maintain the order of related messages while still achieving high throughput.
8. **SQS Message Deduplication**: This feature is used in FIFO queues to prevent the processing of duplicate messages. Each message is assigned a unique deduplication ID, and SQS uses this ID to identify and discard duplicate messages within a 5-minute deduplication interval. This ensures that each message is processed only once, even if it is sent multiple times.
9. **SQS Visibility Timeout**: This is the period of time that a message is invisible to other consumers after it has been received by a consumer. If the consumer does not delete the message within the visibility timeout period, the message becomes visible again and can be processed by other consumers. This helps to prevent message loss in case of processing failures.
10. **SQS Long Polling**: This is a feature that allows consumers to wait for messages to arrive in the queue instead of continuously polling the queue. Long polling reduces the number of empty responses and improves the efficiency of message retrieval. It can be configured by setting the ReceiveMessageWaitTimeSeconds attribute on the queue.
11. **SQS Short Polling**: This is the default behavior of SQS, where consumers continuously poll the queue for messages. Short polling can result in empty responses if there are no messages in the queue, which can lead to increased costs and reduced efficiency.
12. **SQS Message Retention Period**: This is the period of time that messages are retained in the queue before they are automatically deleted. The retention period can be configured from 1 minute to 14 days, depending on the use case. After the retention period expires, messages are permanently deleted from the queue.
13. **SQS Message Delay**: This is the period of time that a message is delayed before it becomes visible to consumers. The delay can be configured from 0 seconds to 15 minutes, depending on the use case. Delayed messages are not visible to consumers until the delay period expires.
14. **SQS Message Encryption**: This feature allows you to encrypt messages in transit and at rest using AWS Key Management Service (KMS). SQS supports server-side encryption (SSE) for messages stored in the queue, ensuring that sensitive data is protected from unauthorized access.
15. **SQS Message Filtering**: This feature allows you to filter messages based on their attributes before they are sent to the consumer. This can be useful for routing messages to specific consumers based on their attributes, reducing the amount of data that needs to be processed by each consumer.
16. **SQS Message Compression**: This feature allows you to compress messages before sending them to the queue, reducing the amount of data that needs to be transmitted and stored. This can be useful for applications that need to send large payloads without exceeding the SQS message size limit.
17. **SQS Message Scheduling**: This feature allows you to schedule messages to be sent to the queue at a specific time in the future. This can be useful for applications that need to send messages at specific intervals or times, such as reminders or notifications.
18. **SQS Message Batching**: This feature allows you to send and receive multiple messages in a single API call, reducing the number of requests and improving throughput. Batching can be used for both standard and FIFO queues, and it can help to reduce costs and improve performance.
19. **SQS Message Visibility Timeout Extension**: This feature allows you to extend the visibility timeout of a message while it is being processed by a consumer. This can be useful for long-running processes that require more time to complete than the default visibility timeout.
20. **SQS Message Redrive Policy**: This feature allows you to configure the redrive policy for a queue, including the maximum number of receive attempts and the DLQ ARN. The redrive policy determines how messages are handled when they cannot be processed successfully, including whether they are sent to a DLQ or deleted from the queue.
21. **SQS Message Dead Letter Queue Redrive Policy**: This feature allows you to configure the redrive policy for a DLQ, including the maximum number of receive attempts and the source queue ARN. The redrive policy determines how messages are handled when they cannot be processed successfully in the DLQ, including whether they are sent to another DLQ or deleted from the queue.
22. **SQS Message Content-Based Deduplication**: This feature allows you to deduplicate messages based on their content instead of using a deduplication ID. This can be useful for applications that need to prevent duplicate messages without relying on a unique identifier.
23. **SQS Message Event Source Mapping**: This feature allows you to configure an event source mapping for a queue, enabling you to trigger AWS Lambda functions or other AWS services when messages are sent to the queue. This can be useful for building event-driven architectures and integrating SQS with other AWS services.
24. **SQS Message Event Filtering**: This feature allows you to filter messages based on their attributes before they are sent to the consumer. This can be useful for routing messages to specific consumers based on their attributes, reducing the amount of data that needs to be processed by each consumer.
25. **SQS Message Event Transformation**: This feature allows you to transform messages before they are sent to the consumer. This can be useful for modifying the message format or structure to match the requirements of the consumer, reducing the need for additional processing.
26. **SQS Message Event Replay**: This feature allows you to replay messages that have been sent to the queue, enabling you to reprocess messages that may have been lost or corrupted. This can be useful for applications that need to recover from failures or errors in message processing.

## SQS Message Lifecycle

The lifecycle of an SQS message includes the following stages:

1. **Message Creation**: A producer creates a message and sends it to the SQS queue.
2. **Message Storage**: The message is stored in the SQS queue until it is consumed by a consumer or until the retention period expires.
3. **Message Retrieval**: A consumer retrieves the message from the queue using the ReceiveMessage API call.
4. **Message Processing**: The consumer processes the message and performs any necessary actions based on the message content.
5. **Message Deletion**: After the message has been successfully processed, the consumer deletes the message from the queue using the DeleteMessage API call.
6. **Message Visibility Timeout**: If the consumer does not delete the message within the visibility timeout period, the message becomes visible again and can be processed by other consumers.
7. **Message Redrive**: If the message cannot be processed successfully after a certain number of attempts, it is sent to a DLQ for further analysis and troubleshooting.
8. **Message Expiration**: If the message is not processed within the retention period, it is automatically deleted from the queue.
9. **Message Archiving**: If the message is sent to a DLQ, it can be archived for future reference or analysis.
10. **Message Deletion from DLQ**: After the retention period for the DLQ expires, the message is permanently deleted from the DLQ.
11. **Message Replay**: If the message is archived, it can be replayed to the original queue or another queue for reprocessing.
12. **Message Monitoring**: The SQS queue can be monitored using Amazon CloudWatch metrics and alarms to track the performance and health of the queue.
13. **Message Auditing**: The SQS queue can be audited using AWS CloudTrail to track API calls and changes to the queue configuration.
14. **Message Security**: The SQS queue can be secured using AWS Identity and Access Management (IAM) policies and roles to control access to the queue and its messages.
15. **Message Encryption**: The SQS queue can be encrypted using AWS Key Management Service (KMS) to protect the messages in transit and at rest.
16. **Message Compression**: The SQS queue can be configured to compress messages before sending them to the queue, reducing the amount of data that needs to be transmitted and stored.
17. **Message Filtering**: The SQS queue can be configured to filter messages based on their attributes before they are sent to the consumer, reducing the amount of data that needs to be processed by each consumer.
18. **Message Scheduling**: The SQS queue can be configured to schedule messages to be sent to the queue at a specific time in the future, enabling time-based processing of messages.
19. **Message Event Source Mapping**: The SQS queue can be configured to trigger AWS Lambda functions or other AWS services when messages are sent to the queue, enabling event-driven architectures and integration with other AWS services.
20. **Message Event Filtering**: The SQS queue can be configured to filter messages based on their attributes before they are sent to the consumer, reducing the amount of data that needs to be processed by each consumer.
21. **Message Event Transformation**: The SQS queue can be configured to transform messages before they are sent to the consumer, enabling modification of the message format or structure to match the requirements of the consumer.
22. **Message Event Replay**: The SQS queue can be configured to replay messages that have been sent to the queue, enabling reprocessing of messages that may have been lost or corrupted.
23. **Message Event Archiving**: The SQS queue can be configured to archive messages that have been sent to the queue, enabling long-term storage and analysis of messages.
24. **Message Event Deletion**: The SQS queue can be configured to delete messages that have been sent to the queue after a certain period of time, enabling automatic cleanup of old messages.
25. **Message Event Monitoring**: The SQS queue can be configured to monitor messages that have been sent to the queue, enabling tracking of the performance and health of the queue.
26. **Message Event Auditing**: The SQS queue can be configured to audit messages that have been sent to the queue, enabling tracking of API calls and changes to the queue configuration.
27. **Message Event Security**: The SQS queue can be configured to secure messages that have been sent to the queue, enabling control of access to the queue and its messages.


## SQS Best Practices

1. **Use FIFO queues for critical message ordering**: If the order of messages is important, use FIFO queues to ensure that messages are processed in the order they are sent.
2. **Use DLQs for error handling**: Configure DLQs to handle messages that cannot be processed successfully after a certain number of attempts. This helps to isolate and troubleshoot problematic messages without affecting the main queue.
3. **Use long polling to reduce costs**: Enable long polling on your queues to reduce the number of empty responses and improve the efficiency of message retrieval.
4. **Use message batching for improved throughput**: Use the SendMessageBatch and ReceiveMessageBatch API calls to send and receive multiple messages in a single request, reducing the number of requests and improving throughput.
5. **Use message attributes for filtering and routing**: Use message attributes to add additional metadata to messages, allowing you to filter and route messages based on their attributes.
6. **Use message compression for large payloads**: Use message compression to reduce the size of messages before sending them to the queue, allowing you to send larger payloads without exceeding the SQS message size limit.
7. **Use message encryption for sensitive data**: Use server-side encryption (SSE) to encrypt messages in transit and at rest, ensuring that sensitive data is protected from unauthorized access.
8. **Use message scheduling for time-based processing**: Use message scheduling to send messages to the queue at a specific time in the future, enabling time-based processing of messages.
9. **Use message event source mapping for integration**: Use event source mapping to trigger AWS Lambda functions or other AWS services when messages are sent to the queue, enabling event-driven architectures and integration with other AWS services.
10. **Use message event filtering for reduced processing**: Use event filtering to filter messages based on their attributes before they are sent to the consumer, reducing the amount of data that needs to be processed by each consumer.
11. **Use message event transformation for format matching**: Use event transformation to modify the message format or structure to match the requirements of the consumer, reducing the need for additional processing.
12. **Use message event replay for recovery**: Use event replay to reprocess messages that may have been lost or corrupted, enabling recovery from failures or errors in message processing.
13. **Use message event archiving for long-term storage**: Use event archiving to store messages for long-term analysis and reference, enabling compliance with data retention policies.
14. **Use message event deletion for automatic cleanup**: Use event deletion to automatically delete messages after a certain period of time, enabling automatic cleanup of old messages.
15. **Use message event monitoring for performance tracking**: Use event monitoring to track the performance and health of the queue, enabling proactive management of the queue.
16. **Use message event auditing for tracking changes**: Use event auditing to track API calls and changes to the queue

## SQS limits

1. **Maximum message size**: 256 KB (262,144 bytes)
   - For messages larger than 256 KB, use the SQS Extended Client Library to store the message payload in Amazon S3 and send a reference to the S3 object in the SQS message.
2. **Maximum number of messages in a batch**: 10 (1 - 10)
   - The maximum number of messages that can be sent or received in a single API call is 10.
   - The maximum size of a batch request is 16 MB (16,777,216 bytes).
   - The maximum size of a single message in a batch request is 256 KB (262,144 bytes).
3. **Maximum number of messages in a queue**: Unlimited
   - There is no limit on the number of messages that can be stored in a queue.
   - However, the total size of all messages in a queue cannot exceed 120,000 messages.
   - The maximum retention period for messages in a queue is 14 days.
4. **Maximum retention period**: 14 days (1 minute - 14 days)
   - The retention period is the amount of time that messages are retained in the queue before they are automatically deleted.
   - The default retention period is 4 days.
   - The minimum retention period is 1 minute, and the maximum retention period is 14 days.
5. **Maximum visibility timeout**: 12 hours ( 0 - 12 hours, default is 30 seconds)
   - The visibility timeout is the period of time that a message is invisible to other consumers after it has been received by a consumer.
   - The default visibility timeout is 30 seconds.
   - The minimum visibility timeout is 0 seconds, and the maximum visibility timeout is 12 hours.
6. **Maximum number of receive attempts**: 10 (1 - 10)
   - The maximum number of times a message can be received before it is sent to a DLQ.
   - The default number of receive attempts is 1.
   - The minimum number of receive attempts is 1, and the maximum number of receive attempts is 10.
7. **Maximum number of message groups in a FIFO queue**: 20,000 (1 - 20,000)
   - The maximum number of message groups that can be created in a FIFO queue.
   - The default number of message groups is 1.
   - The minimum number of message groups is 1, and the maximum number of message groups is 20,000.
8. **Maximum number of message attributes**: 10 (1 - 10)
   - The maximum number of message attributes that can be associated with a message.
   - The default number of message attributes is 0.
   - The minimum number of message attributes is 0, and the maximum number of message attributes is 10.
9. **Throughput limits**:
   - Standard queues: Unlimited
   - FIFO queues: 300 transactions per second (TPS) for each message group, without batching
   - FIFO queues: 3,000 TPS for each message group with batching

10. **Maximum delivery delay**: 15 minutes (0 - 15 minutes)
    - The maximum amount of time that a message can be delayed before it becomes visible to consumers.
    - The default delivery delay is 0 seconds.
    - The minimum delivery delay is 0 seconds, and the maximum delivery delay is 15 minutes.



## Requirements to submit a message to SQS

1. **Queue URL**: The URL of the SQS queue to which the message will be sent.
2. **Message body**: The content of the message, which can be up to 256 KB in size.
3. **Message attributes**: Optional metadata that can be associated with the message, such as custom headers or tags.
4. **Message deduplication ID**: A unique identifier for the message, used to prevent duplicate messages in FIFO queues.
5. **Message group ID**: A unique identifier for the message group, used to maintain the order of messages in FIFO queues.
6. **Message delay**: An optional delay period before the message becomes visible to consumers, which can be set from 0 seconds to 15 minutes.
7. **Message encryption**: Optional server-side encryption (SSE) using AWS Key Management Service (KMS) to protect the message in transit and at rest.

Sample code to send a message to SQS:

```python
import boto3
import json
from botocore.exceptions import ClientError
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def send_message_to_sqs(queue_url, message_body, message_attributes=None, delay_seconds=0):
    """
    Send a message to an SQS queue.

    :param queue_url: The URL of the SQS queue.
    :param message_body: The content of the message.
    :param message_attributes: Optional metadata for the message.
    :param delay_seconds: Optional delay period before the message becomes visible to consumers.
    :return: The response from SQS.
    """
    sqs = boto3.client('sqs')

    try:
        response = sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps(message_body),
            MessageAttributes=message_attributes,
            DelaySeconds=delay_seconds
        )
        return response
    except ClientError as e:
        print(f"Error sending message to SQS: {e}")
        return None
```

## SQS Message Retrieval
To retrieve messages from SQS, you can use the `ReceiveMessage` API call. This call allows you to specify the maximum number of messages to retrieve, the visibility timeout, and other parameters.
The retrieved messages can then be processed by the consumer, and once processed, they should be deleted from the queue using the `DeleteMessage` API call to prevent them from being processed again.

Sample code to retrieve messages from SQS:

```python
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def receive_messages_from_sqs(queue_url, max_messages=10, visibility_timeout=30):
    """
    Receive messages from an SQS queue.
    :param queue_url: The URL of the SQS queue.
    :param max_messages: The maximum number of messages to retrieve.
    :param visibility_timeout: The visibility timeout for the messages.
    :return: A list of messages retrieved from the queue.
    """
    sqs = boto3.client('sqs')

    try:
        response = sqs.receive_message(
            QueueUrl=queue_url,
            MaxNumberOfMessages=max_messages,
            VisibilityTimeout=visibility_timeout,
            WaitTimeSeconds=0
        )
        messages = response.get('Messages', [])
        return messages
    except ClientError as e:
        print(f"Error receiving messages from SQS: {e}")
        return None
```
## SQS Message Deletion

To delete a message from SQS, you can use the `DeleteMessage` API call. This call requires the queue URL and the receipt handle of the message to be deleted. The receipt handle is returned when you receive the message and is used to identify the specific message to be deleted.
Sample code to delete a message from SQS:

```python
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def delete_message_from_sqs(queue_url, receipt_handle):
    """
    Delete a message from an SQS
    :param queue_url: The URL of the SQS queue.
    :param receipt_handle: The receipt handle of the message to be deleted.
    :return: The response from SQS.
    """
    sqs = boto3.client('sqs')
    try:
        response = sqs.delete_message(
            QueueUrl=queue_url,
            ReceiptHandle=receipt_handle
        )
        return response
    except ClientError as e:
        print(f"Error deleting message from SQS: {e}")
        return None
```
## SQS Message Visibility Timeout
The visibility timeout is the period of time that a message is invisible to other consumers after it has been received by a consumer. If the consumer does not delete the message within the visibility timeout period, the message becomes visible again and can be processed by other consumers. This helps to prevent message loss in case of processing failures.

Sample code to set the visibility timeout for a message:

```python
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def set_message_visibility_timeout(queue_url, receipt_handle, visibility_timeout):
    """
    Set the visibility timeout for a message in SQS.
    :param queue_url: The URL of the SQS queue.
    :param receipt_handle: The receipt handle of the message.
    :param visibility_timeout: The visibility timeout in seconds.
    :return: The response from SQS.
    """
    sqs = boto3.client('sqs')
    try:
        response = sqs.change_message_visibility(
            QueueUrl=queue_url,
            ReceiptHandle=receipt_handle,
            VisibilityTimeout=visibility_timeout
        )
        return response
    except ClientError as e:
        print(f"Error setting message visibility timeout: {e}")
        return None
```

## SQS Message Attributes

Message attributes are optional metadata that can be associated with SQS messages. They allow you to add additional information to messages without modifying the message body. Message attributes can be used for filtering, routing, and processing messages based on their attributes.
Sample code to send a message with attributes to SQS:

```python
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def send_message_with_attributes_to_sqs(queue_url, message_body, message_attributes):
    """
    Send a message with attributes to SQS.
    :param queue_url: The URL of the SQS queue.
    :param message_body: The content of the message.
    :param message_attributes: The attributes for the message.
    :return: The response from SQS.
    """
    sqs = boto3.client('sqs')

    try:
        response = sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps(message_body),
            MessageAttributes=message_attributes
        )
        return response
    except ClientError as e:
        print(f"Error sending message with attributes to SQS: {e}")
        return None
```
## SQS Message Filtering
Message filtering allows you to filter messages based on their attributes before they are sent to the consumer. This can be useful for routing messages to specific consumers based on their attributes, reducing the amount of data that needs to be processed by each consumer.
Sample code to filter messages based on attributes:

```python
import boto3
from botocore.exceptions import ClientError
import json
from datetime import datetime, timedelta
from dateutil import parser
from dateutil.tz import tzutc
from dateutil.tz import tzlocal

def filter_messages_by_attribute(queue_url, attribute_name, attribute_value):
    """
    Filter messages based on an attribute.
    :param queue_url: The URL of the SQS queue.
    :param attribute_name: The name of the attribute to filter by.
    :param attribute_value: The value of the attribute to filter by.
    :return: A list of filtered messages.
    """
    sqs = boto3.client('sqs')
    try:
        response = sqs.receive_message(
            QueueUrl=queue_url,
            MessageAttributeNames=[attribute_name],
            MaxNumberOfMessages=10,
            WaitTimeSeconds=0
        )
        messages = response.get('Messages', [])
        filtered_messages = []
        for message in messages:
            attributes = message.get('MessageAttributes', {})
            if attribute_name in attributes and attributes[attribute_name]['StringValue'] == attribute_value:
                filtered_messages.append(message)
        return filtered_messages
    except ClientError as e:
        print(f"Error filtering messages by attribute: {e}")
        return None
```
