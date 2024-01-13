resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.minha_vpc.id
  egress {
    from_port = 0
    to_port = 0
    protocol =  "-1"
    prefix_list_ids = []
  }
    tags = {
    Name = "${var.prefix}-sg"
  }
}

resource "aws_iam_role" "cluster" {
  name = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
{
      "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  POLICY
}