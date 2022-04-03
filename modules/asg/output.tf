output "nginx-asg" {
  description = "Nginx autoscaling group"
  value       = aws_autoscaling_group.nginx-asg.id
}

output "php-asg" {
  description = "PHP autoscaling group"
  value       = aws_autoscaling_group.php-asg.id
}
