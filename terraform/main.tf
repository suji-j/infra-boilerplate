# AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2"
}

# VPC 생성 - CIDR 블록을 지정하고 태그를 추가
resource "aws_vpc" "main" {
  cidr_block = "192.169.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# 서브넷 생성 - VPC 내의 서브넷을 정의하며, 퍼블릭 IP 자동 할당 활성화
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.169.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

# 인터넷 게이트웨이 생성 - VPC와 인터넷을 연결
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# 라우팅 테이블 생성 - VPC 내에서 인터넷으로 트래픽을 라우팅
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  # 모든 트래픽(0.0.0.0/0)을 인터넷 게이트웨이로 라우팅
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

# 라우팅 테이블과 서브넷 연결 - 서브넷에서 라우팅 테이블을 사용하도록 연결
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# 보안 그룹 생성 - EC2 인스턴스의 트래픽을 제어
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  # SSH(포트 22) 트래픽을 허용 (모든 IP로부터)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-sg"
  }
}

# EC2 인스턴스 생성 - t2.medium 유형의 서버를 생성
resource "aws_instance" "web_medium" {
  ami           = "ami-062cf18d655c0b1e8" # Ubuntu 20.04 AMI
  instance_type = "t2.medium"            
  key_name      = "key_name"             
  subnet_id     = aws_subnet.main.id     
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "server"
  }
}

# 출력 - EC2 인스턴스의 퍼블릭 IP를 출력
output "instance_ips" {
  value = [
    aws_instance.web_medium.public_ip
  ]
}

