#!/bin/bash

sudo apt install ${webserver} php -y
sudo service ${webserver} start

echo "<html><h1>Hello SecDevOps</h1></html>" > /var/www/html/hello.html
echo "Hello SecDevOps" > /var/www/html/hello.txt

cat <<EOF | tee /var/www/html/lfi.php
<?php
    \$filename = \$_GET["file"];
    include(\$filename)
?>
EOF

rm -f /var/www/html/index.html

sudo service ${webserver} restart

sudo chown -R ${webserver_user}.${webserver_user} /var/log/${webserver} # enable to lfi.php?file=/var/log/apache2/access.log
sudo chown -R ${webserver_user}.${webserver_user} /var/www/html/ # enable to write reverse_shell.php on this path
