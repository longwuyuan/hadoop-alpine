#!/bin/bash

if [ "${HADOOP_TYPE}" == "master" ]; then
  hdfs --config "/var/hadoop/etc/hadoop" namenode -format -nonInteractive
  /var/hadoop/sbin/hadoop-daemon.sh --config "/var/hadoop/etc/hadoop" --script "/var/hadoop/bin/hdfs" start namenode
else
  while [ "$response" != "200" ]
  do
    response=`curl -s -o /dev/null -w "%{http_code}" http://${HADOOP_MASTER_HOST}:50070`
    echo "Hadoop master is not started..."
    sleep 1
  done
  /var/hadoop/sbin/hadoop-daemon.sh --config "/var/hadoop/etc/hadoop" --script "/var/hadoop/bin/hdfs" start datanode
fi
