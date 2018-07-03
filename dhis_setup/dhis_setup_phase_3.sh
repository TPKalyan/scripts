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

echo "#env variables to start,stop and restart tomcat
alias c_log='tail -f /home/dhis/tomcat-dhis/logs/catalina.out'
alias c_start='/home/dhis/tomcat-dhis/bin/startup.sh & c_log'
alias c_stop='/home/dhis/tomcat-dhis/bin/shutdown.sh'
alias c_restart='c_stop & c_start'
" >> /root/.bashrc

sudo touch /home/dhis/tomcat-dhis/logs/catalina.out

#downloading dhis2 war file
cd tomcat-dhis/webapps/
curl https://s3-eu-west-1.amazonaws.com/releases.dhis2.org/2.25/dhis.war -o ROOT.war
