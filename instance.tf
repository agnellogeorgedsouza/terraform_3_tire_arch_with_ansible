
resource "aws_instance" "nginx-loadbal" {
 count = "1"
 ami = "${lookup(var.AMIS, var.AWS_REGION )}"
 instance_type  = "t2.micro"
 subnet_id = "${aws_subnet.main-pub-1.id}"
 vpc_security_group_ids = ["${aws_security_group.allowPort80.id}","${aws_security_group.allowPort22.id}"]
 key_name = "${aws_key_pair.mykeypair.key_name}"
 tags {
    Name = "${format("nginx-loadbal-%03d", count.index + 1)}"
    servergroup = "loadbalancers"
    Environment = "Dev"
  }
}


resource "aws_instance" "webserver" { 
 count = "2"
 ami = "${lookup(var.AMIS, var.AWS_REGION )}"
 instance_type  = "t2.micro"
 subnet_id = "${aws_subnet.main-pub-1.id}"
 vpc_security_group_ids = ["${aws_security_group.allowPort80.id}","${aws_security_group.allowPort22.id}"]
 key_name = "${aws_key_pair.mykeypair.key_name}"
 tags {
    Name = "${format("webserver-%03d", count.index + 1)}"
    servergroup = "webservers"
    Environment = "Dev"
  }
}

resource "aws_instance" "mgthost" {
 count = "1"
 ami = "${lookup(var.AMIS, var.AWS_REGION )}"
 instance_type  = "t2.micro"
 subnet_id = "${aws_subnet.main-pub-1.id}"
 vpc_security_group_ids = ["${aws_security_group.allowPort22.id}"]
 key_name = "${aws_key_pair.mykeypair.key_name}"

 connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("mykeypair")}"
    timeout = "2m"
    agent = false
}

 
 provisioner "file" {
   source      = "ansible/wordpress_ansible"
    destination = "/tmp"
  }

 provisioner "file" {
    source      = "ansible/script.sh"
    destination = "/tmp/script.sh"
  }

 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /bin/bash /tmp/script.sh",
    ]
 }

 tags {
    Name = "${format("mgthost-%03d", count.index + 1)}"
    servergroup = "controlmachine"
    Environment = "Dev"
  }

}

resource "aws_instance" "database" {
 count = "1"
 ami = "${lookup(var.AMIS, var.AWS_REGION )}"
 instance_type  = "t2.micro"
 subnet_id = "${aws_subnet.main-pri-1.id}"
 vpc_security_group_ids = ["${aws_security_group.allowPort3306.id}","${aws_security_group.allowPort22.id}"]
 key_name = "${aws_key_pair.mykeypair.key_name}"
 tags {
    Name = "${format("database-%03d", count.index + 1)}"
    servergroup = "Database"
    Environment = "Dev"
  }

}
 
