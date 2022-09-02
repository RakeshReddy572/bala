resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "allow admin with ssh"
  vpc_id      = "vpc-07437dab44fb23fce"

  ingress {
    description = "connecting admin on ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["122.175.88.82/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "bastion-sg"
    terraform = "true"
  }
}




resource "aws_security_group" "apache" {
  name        = "apache-demo"
  description = "allow apache"
  vpc_id      = "vpc-07437dab44fb23fce"

  ingress {
    description = "connecting enduser"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks      = [aws_security_group.bastion.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "connecting "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks    = ["122.175.88.82/32"]
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "apache-demo"
    terraform = "true"
  }
}