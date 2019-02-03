#!/bin/bash
aws s3 cp s3://md-sample/grafana.repo /etc/yum.repos.d/grafana.repo
yum install grafana -y
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server
