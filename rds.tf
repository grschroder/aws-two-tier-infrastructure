resource "aws_db_subnet_group" "rds-mysql-app-db-subnet-group" {
  name = "rds-mysql-app-db-subnet-group"
  subnet_ids = [
    aws_subnet.priv-subnet-rds-a.id,
    aws_subnet.priv-subnet-rds-b.id
  ]

  tags = {
    Name = "rds-mysql-app-db-subnet-group"
  }
}

resource "aws_db_instance" "rds-mysql-app-db" {
  identifier              = "rds-mysql-app-db"
  allocated_storage       = 10
  db_name                 = "appdb"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds-mysql-app-db-subnet-group.name  
  vpc_security_group_ids  = [aws_security_group.allow_mysql.id]
  backup_window           = "03:00-04:00"
  backup_retention_period = 1

  tags = {
    Name = "rds-mysql-app-db"
  }

}

resource "aws_db_instance" "rds-mysql-app-db-read-replica" {
  identifier             = "rds-mysql-app-db-read-replica"
  replicate_source_db    = aws_db_instance.rds-mysql-app-db.identifier
  instance_class         = "db.t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  skip_final_snapshot    = true

  tags = {
    Name = "rds-mysql-app-db-read-replica"
  }
}

