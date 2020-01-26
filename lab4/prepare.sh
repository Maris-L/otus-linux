# install mail client and parser hourly crontab
#======================================
yum install mailx -y
echo "0 * * * * root bash /vagrant/logparser.sh" >> /etc/crontab
systemctl restart crond