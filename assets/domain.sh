#!/bin/bash
#
clear
echo ""
echo "******************************************"
echo "*  	  Scar Naruto add Domain		   *"
echo "******************************************"
echo "*       Add New Domain To Server         *"
echo "*          with Let's Encrypt            *"
echo "******************************************"
echo ""
#
read -p 'Set Web Domain (Example: 127.0.0.1 [Not trailing slash!]) : ' domain
read -p 'Email for Lets Encrypt SSL : ' email
#
mkdir /var/www/html/$domain
wget -P /etc/apache2/sites-available https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/Example.conf
mv /etc/apache2/sites-available/Example.conf /etc/apache2/sites-available/$domain.conf
sed -i "s/example.com/$domain/g" /etc/apache2/sites-available/$domain.conf
wget -P /var/www/html/$domain https://raw.githubusercontent.com/abdomuftah/UbuntuServer/main/assets/index.php
a2ensite $domain
systemctl restart apache2
certbot --noninteractive --agree-tos --no-eff-email --cert-name $domain --apache --redirect -d $domain -m $email
systemctl restart apache2.service
certbot renew --dry-run
systemctl restart apache2.service
clear
echo "##################################"
echo "You Can Thank Me On :) "
echo "https://twitter.com/Scar_Naruto"
echo "Join My Discord Server "
echo "https://discord.snyt.xyz"
echo "##################################"
echo " ypur Domain is now ready  : "
echo "	 https://$domain 	"
#
exit