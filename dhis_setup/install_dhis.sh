#creating user
# sudo su
sudo useradd -d /home/dhis -m dhis -s /bin/false
passwd dhis

#creating config
mkdir /home/dhis/config
chown dhis:dhis /home/dhis/config

#locale
sudo dpkg-reconfigure tzdata

echo "export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
" >> /root/.bashrc
. /root/.bashrc

echo "export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
" >> /home/vagrant/.bashrc

echo "export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
" >> /home/dhis/.bashrc

locale -a
sudo locale-gen nb_NO.UTF-8

#installing and setting up postgresql
sudo apt-get update -y && apt-get upgrade -y
echo '
# PostgreSQL repository
deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
' >> /etc/apt/sources.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update -y
sudo apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-9.5-postgis-2.2

#Creating user
sudo -u postgres createuser -SDRP dhis
#Creating database
sudo -u postgres createdb -O dhis dhis2

#configuring postgres
echo '
max_connections = 200
shared_buffers = 3200MB
work_mem = 20MB
maintenance_work_mem = 512MB
effective_cache_size = 8000MB
checkpoint_completion_target = 0.8
synchronous_commit = off
wal_writer_delay = 10000ms
' >> /etc/postgresql/9.5/main/postgresql.conf

#creating extension postgis
psql -c "create extension postgis;" dhis2

#creating config file for dhis2
echo '# Hibernate SQL dialect
connection.dialect = org.hibernate.dialect.PostgreSQLDialect

# JDBC driver class
connection.driver_class = org.postgresql.Driver

# Database connection URL
connection.url = jdbc:postgresql:dhis2

# Database username
connection.username = dhis

# Database password
connection.password = password

# Database schema behavior, can be validate, update, create, create-drop
connection.schema = update' > /home/dhis/config/dhis.conf

chmod 0600 /home/dhis/config/dhis.conf

#installing java8
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y


#installing tomcat-user
cd /home/dhis/
sudo apt-get install tomcat7-user -y
tomcat7-instance-create tomcat-dhis
echo "export JAVA_HOME='/usr/lib/jvm/java-8-oracle/'
export JAVA_OPTS='-Xmx7500m -Xms4000m'
export DHIS2_HOME='/home/dhis/config'" >> tomcat-dhis/bin/setenv.sh

#creating aliases
echo "#env variables to start,stop and restart tomcat
alias c_log='tail -f /home/dhis/tomcat-dhis/logs/catalina.out'
alias c_start='/home/dhis/tomcat-dhis/bin/startup.sh & c_log'
alias c_stop='/home/dhis/tomcat-dhis/bin/shutdown.sh'
alias c_restart='c_stop & c_start'
" >> /root/.bashrc

. /root/.bashrc

sudo touch /home/dhis/tomcat-dhis/logs/catalina.out

#downloading dhis2 war file
cd tomcat-dhis/webapps/
wget https://s3-eu-west-1.amazonaws.com/releases.dhis2.org/2.30/dhis.war
mv dhis.war ROOT.war
