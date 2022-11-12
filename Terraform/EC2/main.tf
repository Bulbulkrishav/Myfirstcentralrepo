resource "aws_instance" "Demo" {
    ami   = "ami-0c4e4b4eb2e11d1d4"
    instance_type = "t2.micro"
    key_name = "linuxpractice"
    tags = {
        Name = "Demo"
    }
}