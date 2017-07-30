FROM alpine

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH ${JAVA_HOME}/bin:${PATH}
ENV HADOOP_MASTER_HOST localhost
ENV HADOOP_TYPE master

RUN apk -U update && \
  apk add bash curl openssh-client wget openssl openjdk8-jre supervisor && \
  apk upgrade && \
  curl http://mirrors.ukfast.co.uk/sites/ftp.apache.org/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz | tar xvz && \
  mv hadoop-2.8.1 /var/hadoop && \
  rm -rf /var/hadoop/share/doc && \
  mkdir -p /var/hadoop_data/hdfs/namenode && \
  mkdir -p /var/hadoop_data/hdfs/datanode

COPY start.sh /start.sh

EXPOSE 8088 50070

CMD ["/bin/sh","/start.sh"]
