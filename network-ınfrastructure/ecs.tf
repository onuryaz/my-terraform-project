resource "aws_alb" "main" {
  name            = "ecs-alb"
  subnets         =  ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}", "${aws_subnet.public-subnet-3.id}"]
}

resource "aws_alb_target_group" "app" {
  name        = "ecs-target-group"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.ecs.id}"
  target_type = "ip"
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.arn}"   #check
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.app.arn}"  # check
    type             = "forward"
  }
}


resource "aws_ecs_cluster" "main" {
  name = "fargate-cluster"
}

data "template_file" "flask" {
  template = "${file("task_definitions/fargate.json")}"

}

resource "aws_ecs_task_definition" "flask" {
  family                = "flask-app"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  container_definitions = "${data.template_file.flask.rendered}"
  execution_role_arn = "${aws_iam_role.ecs_task_assume.arn}"
}


resource "aws_ecs_service" "flask-service" {
  name            = "flask"
  cluster         = "${aws_ecs_cluster.main.id}"
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.flask.arn}"
  desired_count   = 1

  network_configuration = {
    subnets = ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}"]

    assign_public_ip = true
  
  
  }

  load_balancer {
   target_group_arn = "${aws_alb_target_group.app.arn}"
   container_name = "flask"
   container_port = 5000
  }
  

  depends_on = [
    "aws_alb_listener.front_end"
  ]
}

