resource "aws_db_instance" "primary" {
  identifier = "${var.stack_name}-primary"
  name = var.db_name
  password = var.db_password
  username = var.db_username
  instance_class = var.db_instance
  allocated_storage = 5
  storage_type = "gp2"
  engine = "mariadb"
  engine_version = "10.4.8"
  multi_az = true
  publicly_accessible = false
  tags = {
    Name = var.stack_name
  }
}
