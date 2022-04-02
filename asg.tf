resource "aws_key_pair" "lab-key" {
  key_name   = "lab-key"
  public_key = file("keys/key.pub")
}

resource "aws_launch_template" "lab-nginx-lt" {
  name                                 = "lab-nginx"
  image_id                             = var.instance-image
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance-type
  key_name                             = "lab-key"
  #  vpc_security_group_ids               = [aws_security_group.public-sg.id]
  #user_data = "${base64encode(file("${path.module}/userdata/nginx.sh"))}"
  #user_data = filebase64("${path.module}/userdata/nginx.sh")
  user_data = "${base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo cat << 'EOFF' > /etc/nginx/sites-available/default
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;

  index index.html index.php index.htm index.nginx-debian.html;

  server_name _;

  location / {
    try_files $uri $uri/ =404;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass ${aws_lb.lab-php-lb.dns_name}:9000;
  }
}
EOFF

sudo systemctl start nginx
sudo systemctl enable nginx
sudo touch /var/www/html/index.php
sudo touch /var/www/html/phpinfo.php
sudo touch /var/www/html/db.php
EOF
)}"

  lifecycle {
    create_before_destroy = true
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.public-sg.id]
    #    subnet_id                   = aws_subnet.name1.id
    delete_on_termination = true
  }
  tags = {
    Environment = "Lab"
  }
}

resource "aws_autoscaling_group" "nginx-asg" {
  name                = "Lab-nginx-asg"
  min_size            = 1
  max_size            = 5
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.lab-public-subnet-1.id, aws_subnet.lab-public-subnet-2.id]

  launch_template {
    id      = aws_launch_template.lab-nginx-lt.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "lab-php-lt" {
  name                                 = "lab-php"
  image_id                             = var.instance-image
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance-type
  key_name                             = "lab-key"
  #  vpc_security_group_ids               = [aws_security_group.public-sg.id]
  #user_data = filebase64("${path.module}/userdata/php.sh")
  user_data = "${base64encode(<<EOF
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
  echo 'Default PHP webpage <br/>';
  echo '<a href="db.php">DB TEST</a>';
  echo '<a href="phpinfo.php">php info</a>';

?>
EOFF

sudo cat << 'EOFF' > /var/www/html/db.php
  <?php
  $servername = "${aws_db_instance.lab-db.address}";
  $username = "${aws_db_instance.lab-db.username}";
  $password = "${aws_db_instance.lab-db.password}";
  $db = "${aws_db_instance.lab-db.db_name}";
  try {
    $conn = new PDO("mysql:host=$servername;dbname=".$db, $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully " .$db ." on host: ".$servername;
    }
  catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
  ?>
EOFF
EOF
)}"

  lifecycle {
    create_before_destroy = true
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.private-sg.id]
    #    subnet_id                   = aws_subnet.name1.id
    delete_on_termination = true
  }
  tags = {
    Environment = "Lab"
  }
}

resource "aws_autoscaling_group" "php-asg" {
  name                = "Lab-php-asg"
  min_size            = 1
  max_size            = 5
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.lab-private-subnet-1.id, aws_subnet.lab-private-subnet-2.id]

  launch_template {
    id      = aws_launch_template.lab-php-lt.id
    version = "$Latest"
  }
}