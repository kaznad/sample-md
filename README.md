# Monitoring Stack

Simple monitoring stack

## Description

Stack to monitor instance CPU, Memory and Disk Usage

## Getting Started

### Dependencies

Installing on AWS EC2 instance

Ensure that a role with S3 read access is given to EC2 instance and create a security group that allows ports 80, 2024, 2003, 2023, 9090, 8216, 3000, 9100, 8125, 2004 and 22
  
### Installing

When launching an EC2 instance enter the following in the userdata
```
#!/bin/bash
yum update -y
yum install git -y
git clone https://github.com/kaznad/sample-md.git
cd sample-md/scripts
chmod +x build_prometheus.sh
./build_prometheus.sh
chmod +x build_graphite.sh
./build_graphite.sh
chmod +x build_grafana.sh
./build_grafana.sh
```
