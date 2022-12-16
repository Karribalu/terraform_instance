resource "aws_instance" "web1" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.prod-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH key
  key_name = aws_key_pair.london-region-key-pair.id

  # nginx installation
  provisioner "file" {
    source      = "ansible.sh"
    destination = "/tmp/ansible.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansible.sh",
      "sudo /tmp/ansible.sh"
    ]
  }

  connection {
    host        = self.public_ip
    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }
  tags = {
    Name = "Ansible-Instance"
  }
}


resource "aws_instance" "web2" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.prod-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH key
  key_name = aws_key_pair.london-region-key-pair.id

  connection {
    host        = self.public_ip
    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }
  tags = {
    Name = "Jenkins-Node"
  }
}
resource "aws_key_pair" "london-region-key-pair" {
  key_name   = "tokyo-new-key-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}
