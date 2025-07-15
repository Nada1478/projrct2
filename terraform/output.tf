output "wordpress_instance_public_ip" {
  value = aws_instance.wordpressserver.public_ip
  description = "Public IP address of the WordPress EC2 instance"
}

