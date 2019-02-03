#!/bin/bash
yum install -y httpd net-snmp perl pycairo mod_wsgi python-devel git gcc-c++
sudo yum install -y http://epel.mirror.constant.com/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
yum update -y
yum repolist
yum install -y python-pip node npm
pip install --upgrade pip
pip install 'django<1.6'
pip install 'Twisted<12'
pip install django-tagging
pip install whisper
pip install carbon
yum install -y graphite-web
cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf
cp /opt/graphite/conf/storage-aggregation.conf.example /opt/graphite/conf/storage-aggregation.conf
cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
chown -R apache:apache /opt/graphite/storage/
aws s3 cp s3://md-sample/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
PYTHONPATH=/usr/share/graphite/webapp django-admin syncdb --settings=graphite.settings --noinput
echo "from django.contrib.auth.models import User; User.objects.create_superuser('root', 'admin@example.com', 'password')" | python /usr/lib/python2.7/site-packages/graphite/manage.py shell
echo > /etc/httpd/conf.d/welcome.conf
aws s3 cp s3://md-sample/graphite-web.conf /etc/httpd/conf.d/graphite-web.conf
chown apache:apache /var/lib/graphite-web/graphite.db
touch /var/lib/graphite-web/index
systemctl daemon-reload
systemctl start httpd
systemctl enable httpd
