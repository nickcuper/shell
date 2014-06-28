#!/bin/bash
echo "Make sure you have permissions to edit vhosts and reload apache."
echo "This script will create a vhost."
echo "If enter domain git will be init repo"
echo "domain git"
read domain isgit


echo "creating html directory"
mkdir /home/dmitrii/lamp/$domain
echo "Creating the vhost config file"
cat <<EOF > /etc/apache2/sites-available/$domain
<VirtualHost *:80>
    ServerAdmin webmaster@$domain.local
    DocumentRoot /home/dmitrii/lamp/$domain
    ServerName $domain.local
    ServerAlias www.$domain.local
    ErrorLog /home/dmitrii/lamp/logs/$domain.error.log
    CustomLog /home/dmitrii/lamp/logs/$domain.access.log combined
  <Directory /home/dmitrii/lamp/$domain>
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>
</VirtualHost>
EOF
echo "enabling site"
a2ensite $domain
echo "restarting apache"
/etc/init.d/apache2 reload