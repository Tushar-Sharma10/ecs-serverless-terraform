resource "aws_efs_file_system" "efs" {
  creation_token   = var.creation_token
  performance_mode = var.performance_mode
  encrypted        = var.encrypted
  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }
  tags = {
    Name = "App-EFS"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count           = length(module.vpc.private_subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.private_subnet_ids[count.index]
  security_groups = [aws_security_group.efs_sg.id]
  depends_on      = [aws_security_group.efs_sg, aws_efs_file_system.efs]
}

resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow NFS access from ecs tasks"
  vpc_id      = module.vpc.vpc_id
  depends_on  = [module.vpc]
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
  security_group_id = aws_security_group.efs_sg.id
  description       = "NFS port"
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.efs_sg.id
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
}
