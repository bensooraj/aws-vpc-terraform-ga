# ALB
resource "aws_alb" "alb" {
    name = "application-load-balancer"
    internal = false

    load_balancer_type = "application"
    security_groups = [ var.sg_id ] 
    subnets = var.subnet_ids 
}

# Listener
resource "aws_alb_listener" "alb_listener" {
    load_balancer_arn = aws_alb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_alb_target_group.alb_target_group.arn
    }
}

# Target Group
resource "aws_alb_target_group" "alb_target_group" {
    name = "alb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "instance"
} 

# Target Group Attachment
resource "aws_alb_target_group_attachment" "alb_target_group_attachment" {
    count = length(var.instance_ids)
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    target_id = var.instance_ids[count.index] 
    port = 80
} 