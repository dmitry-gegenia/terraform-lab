resource "aws_ssm_parameter" "db-user" {
  name        = "/lab/database/user"
  description = "DB user"
  type        = "String"
  value       = var.db_user

  tags = {
    environment = "lab"
  }
}

resource "aws_ssm_parameter" "db-secret" {
  name        = "/lab/database/password"
  description = "DB password"
  type        = "SecureString"
  value       = var.db_pass

  tags = {
    environment = "lab"
  }
}