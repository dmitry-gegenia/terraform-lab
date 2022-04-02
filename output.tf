output "nginx_dns_name" {
  value       = aws_lb.lab-nginx-lb.dns_name
  description = "The domain name of the nginx load balancer"
}

output "php_dns_name" {
  value       = aws_lb.lab-php-lb.dns_name
  description = "The domain name of the php load balancer"
}

output "rds" {
  value       = aws_db_instance.lab-db.address
  description = "RDS"

}