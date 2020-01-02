# cluster

resources "aws_ecs_cluster" "example-cluster" {

name = "example-cluster"
 
}

resources "aws_launch_configuration" "ecs-example-launchconfig" 
{
	name = "ecs-launchconfig"
	image_id ="ami id from aws declare in .var "
	instance_type = "t2.micro from aws declare in .var "
	key_name = "$[aws_key_pair.mykeypair.key_name]"
	iam_instance_profile = "${aws_iam_instance_profile.ecs-ec2-role.id}"//ec2 need extra permission
	security_group =["${aws_security_group.ecs-securitygroup.id}"]
	user data = "#!/bin/bash\necho 'ECS_CLUSTER=example-cluster'>/etc/ecs/ecs.config\nstart ecs"
	lifecycle {create_before_destroy = true }

}

resources "aws_autoscaling_group" "ecs-example-autoscaling"{
	name = "ecs-example-autoscaling"
	vpc_zone_identifier =["${aws_subnet.main-public-1.id]","${aws_subnet.main-public-2.id}"]
	launch_configuration = "${aws_launch_configuration.ecs-example-launchconfig.name]"
	min_size =1
	max_size =1
	tag {
	key ='Name'
	value = 'ecs-ec2-container'
	propagate_at_launch= true

}
}