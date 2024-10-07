
// Output the security group id
output "frontend_security_group" {
    value = aws_security_group.frontend_security_group.id
}
// Application security group id
output "application_security_group" {
    value = aws_security_group.application_security_group.id
}
// Application security group id
output "database_security_group" {
    value = aws_security_group.database_securty_group.id
}