#!/bin/bash
#
clear
echo ""
echo "******************************************"
echo "*   Scar Naruto UBUNTU 18 + Script       *"
echo "******************************************"
echo "*       this script well install         *"
echo "*      LAMP server and phpMyAdmin        *"
echo "*     With node js and secure your       *"
echo "*      Domain with Let's Encrypt         *"
echo "******************************************"
echo ""
#
read -p 'Set Web Domain (Example: 127.0.0.1 [Not trailing slash!]) ' domain
#
apt update
apt upgrade -y
apt-get update 
apt-get upgrade -y
apt dist-upgrade
apt autoremove -y
apt-get install default-jdk -y
apt-get install software-properties-common -y
apt-add-repository ppa:webupd8team/java -y
add-apt-repository ppa:ondrej/php -y
add-apt-repository ppa:phpmyadmin/ppa -y
add-apt-repository ppa:deadsnakes/ppa -y
add-apt-repository -y ppa:chris-lea/redis-server
#
apt update
apt upgrade -y
apt-get update 
apt-get upgrade -y
#
echo "=================================="
echo " install some tools to help you more :) "
echo "=================================="
apt-get install -y screen nano curl git zip unzip ufw certbot python3-certbot-apache
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
apt-get install -y python3.7 libmysqlclient-dev python3-dev python3-pip 
python3 get-pip.py
python3 -m pip install Django
#
echo "=================================="
echo "installing Apache2"
echo "=================================="
apt install apache2
#
systemctl stop apache2.service
systemctl start apache2.service
systemctl enable apache2.service
#
ufw app list
ufw allow in 80
ufw allow in 443
#
echo "=================================="
echo "installing mySQL :"
echo "=================================="
apt-get -y install mariadb-server mariadb-client
# if Ubuntu 18.04+
systemctl stop mariadb.service
systemctl start mariadb.service
systemctl enable mariadb.service
#
mysql_secure_installation
#
systemctl restart mysql.service
#
apt update
apt upgrade -y
apt-get update 
apt-get upgrade -y
#
echo "=================================="
echo "installing PHP 7.4 + modules"
echo "=================================="
apt install -y php7.4 libapache2-mod-php7.4 php7.4-common php7.4-mbstring php7.4-xmlrpc php7.4-soap php7.4-gd php7.4-bz2 php7.4-xml php7.4-intl php7.4-mysql php7.4-cli php7.4-zip php7.4-curl php7.4-pdo php7.4-tokenizer php7.4-bcmath php7.4-fpm php7.4-imagick php7.4-tidy tar redis-server sed composer
systemctl restart apache2.service
#
echo "=================================="
echo "Install and Secure phpMyAdmin"
echo "=================================="
apt update
apt upgrade -y
apt-get update 
apt-get upgrade -y
apt-get install -y phpmyadmin php7.4-gettext
#
echo "=================================="
echo "Update php.ini file "
echo "=================================="
wget https://raw.githubusercontent.com/abdomuftah/Ubuntu-Script/master/php.ini && mv -f php.ini /etc/php/7.4/apache2/
#wget -O php.ini https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/php7.4.ini
mv php.ini /etc/php/7.4/apache2/
#
a2enmod rewrite
systemctl restart apache2.service
systemctl restart apache2
#
wget -P /etc/apache2/sites-available https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/Example.conf
cp /etc/apache2/sites-available/Example.conf /etc/apache2/sites-available/$domain.conf
sed -i "s/example.com/$domain/g" /etc/apache2/sites-available/$domain.conf
a2ensite $domain
systemctl restart apache2
#
add-apt-repository -r ppa:ondrej/php -y
add-apt-repository -r ppa:phpmyadmin/ppa -y
add-apt-repository -r ppa:webupd8team/java -y
add-apt-repository -r ppa:chris-lea/redis-server -y
add-apt-repository -r ppa:deadsnakes/ppa -y
#
apt update
apt upgrade -y
apt-get update 
apt-get upgrade -y
#
echo "=================================="
echo "Installing nodeJS"
echo "=================================="
apt-get install -y gcc g++ make nodejs npm 
#
apt update -y && apt upgrade -y
apt-get update && apt-get upgrade -y
systemctl restart apache2.service
#
echo "=================================="
echo "Installing glances "
echo "=================================="
pip install 'glances[browser]'
wget -P /etc/systemd/system/ https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/glances.service
systemctl enable glances.service
systemctl start glances.service
systemctl enable glances.service
systemctl start glances.service
#
#mysql -u "use mysql; update user set plugin='' where User='root'; FLUSH PRIVILEGES;"
wget https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/fix.sql
mysql -u root < fix.sql 
service mysql restart
systemctl restart apache2.service
#delay 30
clear
#
echo "your PHP Ver is :"
php -v 
#
echo ""
echo "You Can Thank Me On :) "
echo "https://twitter.com/Scar_Naruto"
echo "to cheack your server status go to http://$domain:61208 "
#
exit
