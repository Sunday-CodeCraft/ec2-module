output "ec2" {
  description = "EC2 attributees"
  value       = aws_instance.unprotected == [] ? aws_instance.protected[0] : aws_instance.unprotected[0]
}