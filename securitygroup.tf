
resource"aws_security_group""ecs-securitygroup"{
vpc_id = "from vpc.main.id"
name = "ecs"
description ="security group for ecs and all egress traffic"
egress {

from_port =0
to_port = 0
protocol ="-1" //all protocals
cidr_block=["0.0.0.0./0"]// allowing everything 

}


ingress {
//incoming traffic

from_port ="3000"
to_port = "3000"//tto connect ip address 
protocol ="tcp" 
security_groups=["{aws_security_group.myapp-elb-securitygroup.id}"]

}
ingress {
//incoming traffic

from_port ="22"
to_port = "22"//to connect ip address 
protocol ="tcp"
cidr_block=["{0.0.0.0/0}"]

}

tags {
Name = "ecs"
}

}



resource"aws_security_group" "myapp-elb-securitygroup"{
vpc_id = "aws-from vpc.main.id"
name = "myapp-elb"
description ="security group for ecs"
egress {

from_port =0
to_port = 0
protocol ="-1" //all protocals
cidr_block=["0.0.0.0./0"]// allowing everything 

}


ingress {
//incoming traffic

from_port ="80"
to_port = "80"//tto connect ip address 
protocol ="tcp" 
cidr_block=["{0.0.0.0/0}"]

}

tags {
Name = "myapp-elb"
}

}




