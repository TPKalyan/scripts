#creating user
# sudo su
useradd -d /home/dhis -m dhis -s /bin/bash
usermod -G sudo dhis
passwd dhis

#creating config
mkdir /home/dhis/config

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
sudo apt-get install postgresql-9.4 postgresql-contrib-9.4 postgresql-9.4-postgis-2.2 -y
sudo su postgres
