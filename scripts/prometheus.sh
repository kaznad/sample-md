#!/bin/bash
yum update -y
useradd --no-create-home --shell /bin/false prometheus
useradd --no-create-home --shell /bin/false node_exporter
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
cd ~
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.0.0/prometheus-2.0.0.linux-amd64.tar.gz
tar xvf prometheus-2.0.0.linux-amd64.tar.gz
cp prometheus-2.0.0.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.0.0.linux-amd64/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
cp -r prometheus-2.0.0.linux-amd64/consoles /etc/prometheus
cp -r prometheus-2.0.0.linux-amd64/console_libraries /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
rm -rf prometheus-2.0.0.linux-amd64.tar.gz prometheus-2.0.0.linux-amd64
aws s3 cp s3://md-sample/prometheus.yml /etc/prometheus/prometheus.yml
chown prometheus:prometheus /etc/prometheus/prometheus.yml
aws s3 cp s3://md-sample/prometheus.service /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
