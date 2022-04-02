#!/bin/bash
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install php7.3 php7.3-cli php7.3-fpm php7.3-json php7.3-pdo php7.3-mysql php7.3-zip php7.3-gd  php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-json -y
sudo sed -i 's/\/run\/php\/php7.3-fpm.sock/0.0.0.0:9000/' /etc/php/7.3/fpm/pool.d/www.conf
sudo systemctl restart php7.3-fpm.service
sudo mkdir -p /var/www/html
sudo cat << 'EOFF' > /var/www/html/phpinfo.php
<?php
  phpinfo();
?>
EOFF

sudo cat << 'EOFF' > /var/www/html/index.php
<?php
  echo 'Default PHP webpage';
?>
EOFF

sudo cat << 'EOFF' > /var/www/html/db.php
  <?php
  $servername = "localhost";
  $username = "admin";
  $password = "12345678";
  $db = "dbname";
  try {
    $conn = new PDO("mysql:host=$servername;dbname=myDB", $username, $password, $db);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully";
    }
  catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
  ?>
EOFF
