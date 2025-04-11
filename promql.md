# PromQL queries

PromQL queries and their explanations.

## Ceph OSDs

```plaintext
sum(
  ceph_osd_stat_bytes{cluster=~"$cluster", } and
    on (ceph_daemon) ceph_disk_occupation{instance=~"($ceph_hosts)([\\\\.:].*)?", cluster=~"$cluster", }
)
```

The above query calculates the total number of bytes used by Ceph OSDs in a given cluster. It uses the `ceph_osd_stat_bytes` metric to get the total bytes and the `ceph_disk_occupation` metric to filter the results based on the specified cluster and Ceph hosts. The `and` operator is used to combine the two metrics, and the `on (ceph_daemon)` clause ensures that the results are grouped by the `ceph_daemon` label.


## Disk IOPS

```plaintext
label_replace(
  (
    rate(node_disk_writes_completed{instance=~"($ceph_hosts)([\\\\.:].*)?"}[$__rate_interval]) or
    rate(node_disk_writes_completed_total{instance=~"($ceph_hosts)([\\\\.:].*)?"}[$__rate_interval])
  ), "instance", "$1", "instance", "([^:.]*).*"
) * on(instance, device) group_left(ceph_daemon) label_replace(
  label_replace(
    ceph_disk_occupation_human{cluster=~"$cluster", }, "device", "$1", "device", "/dev/(.*)"
  ), "instance", "$1", "instance", "([^:.]*).*"
)
```

The above query calculates the disk IOPS (Input/Output Operations Per Second) for Ceph OSDs. It uses the `node_disk_writes_completed` and `node_disk_writes_completed_total` metrics to get the write operations completed on the disks. The `rate` function is used to calculate the rate of change over a specified interval. The `label_replace` function is used to extract the instance and device labels from the metrics. The `on(instance, device)` clause ensures that the results are grouped by both instance and device labels, and the `group_left(ceph_daemon)` clause allows for joining with the `ceph_daemon` label.






label_replace(
  (
    (rate(node_disk_io_time_ms{instance=~"(venice)([\\\\.:].*)?"}[1m0s]) / 10) or
    rate(node_disk_io_time_seconds_total{instance=~"(venice)([\\\\.:].*)?"}[1m0s]) * 100
  ), "instance", "$1", "instance", "([^:.]*).*"
) * on(instance, device) group_left(ceph_daemon) label_replace(
  label_replace(ceph_disk_occupation_human{instance=~"(venice)([\\\\.:].*)?", cluster=~"cephbw-dev", },
  "device", "$1", "device", "/dev/(.*)"), "instance", "$1", "instance", "([^:.]*).*"
)




label_replace(
  (
    rate(node_disk_writes_completed{instance=~"(orlando)([\\\\.:].*)?"}[$__rate_interval]) or
    rate(node_disk_writes_completed_total{instance=~"(orlando)([\\\\.:].*)?"}[$__rate_interval])
  ), "instance", "$1", "instance", "([^:.]*).*"
) * on(instance, device) group_left(ceph_daemon) label_replace(
  label_replace(
    ceph_disk_occupation_human{cluster=~"ceph-dev", }, "device", "$1", "device", "/dev/(.*)"
  ), "instance", "$1", "instance", "([^:.]*).*"
)



rate(node_disk_writes_completed_total{cluster="cephbw-dev",instance="orlando"}[$__rate_interval]) or rate(node_disk_writes_completed{cluster="cephbw-dev",instance="orlando"}[$__rate_interval])



node_disk_writes_completed{
    instance=~"(orlando)([\\\\.:].*)?"
    }
