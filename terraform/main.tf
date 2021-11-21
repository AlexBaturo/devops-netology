provider "aws" {
	region                  = "us-west-2"
}

resource "aws_vpc" "myVpc" {
	cidr_block = "172.20.0.0/16"
}

resource "aws_subnet" "mySubnet" {
  	vpc_id            = aws_vpc.myVpc.id
  	cidr_block        = "172.20.10.0/24"
  	availability_zone = "us-west-2a"
}

resource "aws_network_interface" "myNetInterface" {
  	subnet_id   = aws_subnet.mySubnet.id
  	private_ips = ["172.20.10.100"]
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myVolume.id
  instance_id = aws_instance.myInstance.id
}

resource "aws_ebs_volume" "myVolume" {
  availability_zone = "us-west-2a"
  size              = 1
}

data "aws_ami" "myUbuntu" {
	most_recent = true

	filter {
		name   = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
	}

	filter {
		name   = "virtualization-type"
		values = ["hvm"]
	}

	owners = ["099720109477"]
}

resource "aws_instance" "myInstance" {
	ami           = data.aws_ami.myUbuntu.id
	instance_type = "t2.micro"
	availability_zone = "us-west-2a"

	network_interface {
    	network_interface_id = aws_network_interface.myNetInterface.id
    	device_index         = 0
  	}

	tags = {
		Name = "HelloWorld"
	}
}
