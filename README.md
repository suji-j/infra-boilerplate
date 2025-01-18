## Infra Boilerplate Repository
이 레포지토리는 Docker, Kubernetes 매니페스트, Jenkins 파이프라인 스크립트, Terraform 코드와 같은 인프라 설정 및 관리를 위한 BoilerPlate 코드를 제공합니다. 
이 레포지토리는 DevOps 및 클라우드 인프라를 빠르고 효율적으로 구축하기 위해 설계되었습니다.

---
### 주요 특징

### 1️⃣ Jenkins

CI/CD 파이프라인을 구현하기 위한 Jenkinsfile 제공합니다.
- GitHub 저장소에서 소스 코드 체크아웃.
- 기존 Docker 이미지 정리 및 새로운 이미지 빌드.
- 빌드된 Docker 이미지를 AWS Elastic Container Registry(ECR)에 푸시.
- Kubernetes 매니페스트 파일의 이미지 태그 자동 업데이트.
- Discord 웹훅을 통해 빌드 상태 알림 전송.
<br/><br/>

### 2️⃣ Terraform

AWS에서 EC2 인스턴스를 생성하고 필요한 리소스들을 구성하기 위한 테라폼 설정을 포함하고 있습니다.
- VPC : 192.169.0.0/16 CIDR 블록을 사용하는 기본 VPC
- 서브넷 : 퍼블릭 IP 자동 할당이 활성화된 서브넷
- 인터넷 게이트웨이 : VPC와 인터넷 연결을 위한 인터넷 게이트웨이
- 라우팅 테이블 : VPC 내에서 인터넷으로 트래픽을 라우팅하는 라우팅 테이블
- 보안 그룹 : EC2 인스턴스의 SSH(포트 22) 액세스를 허용하는 보안 그룹
- EC2 인스턴스 : 기본 설정으로 EC2 인스턴스를 t2.medium 타입으로 생성

적용 방법
```
# 필요한 프로바이더와 플러그인을 초기화
terraform init

# 실행 계획을 확인하여 리소스들이 올바르게 설정될지 미리 확인
terraform plan

# 인프라를 실제로 생성
teeraform apply
```
