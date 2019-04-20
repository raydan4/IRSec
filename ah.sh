#!/bin/bash
c=/etc/apache2/apache2.conf

echo "ServerTokens Prod" >> $c
echo "ServerSignature Off" >> $c
sed -i 's/Options FollowSymlinks/Options -Indexesi\nAllowOverride None/g' $c
echo "FileETag None" >> $c
echo "TraceEnable off" >> $c
echo "Header always append X-Frame-Options SAMEORIGIN" >> $c
echo "Header set  X-XXS-Protection \"1; mode=block\"" >> $c
a2enmod head*
service apache2 restart
