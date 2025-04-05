## Infra Boilerplate Repository
이 레포지토리는 Docker, Kubernetes 매니페스트, Jenkins 파이프라인 스크립트, Terraform 코드와 같은 인프라 설정 및 관리를 위한 BoilerPlate 코드를 제공합니다. 
이 레포지토리는 DevOps 및 클라우드 인프라를 빠르고 효율적으로 구축하기 위해 설계되었습니다.

---

### 1️⃣ Jenkins

CI/CD 파이프라인을 구현하기 위한 Jenkinsfile 제공합니다.
1. GitHub 저장소에서 소스 코드 체크아웃
2. 기존 Docker 이미지 정리 및 새로운 이미지 빌드
3. 빌드된 Docker 이미지를 AWS Elastic Container Registry(ECR)에 푸시
4. k8s / sshPublisher
    - Kubernetes 매니페스트 파일의 이미지 태그 자동 업데이트
    - EC2 인스턴스에 SSH를 통해 접속하여 ECR에서 최신 이미지를 Pull 후 서버에 배포
6. Discord 웹훅을 통해 빌드 상태 알림 전송
<br/><br/>

### 2️⃣ Terraform

AWS에서 EC2 인스턴스를 생성하고 필요한 리소스들을 구성하기 위한 테라폼 설정을 포함하고 있습니다.
- VPC : 192.169.0.0/16 CIDR 블록을 사용하는 기본 VPC
- 서브넷 : 퍼블릭 IP 자동 할당이 활성화된 서브넷
- 인터넷 게이트웨이 : VPC와 인터넷 연결을 위한 인터넷 게이트웨이
- 라우팅 테이블 : VPC 내에서 인터넷으로 트래픽을 라우팅하는 라우팅 테이블
- 보안 그룹 : EC2 인스턴스의 SSH(포트 22) 액세스를 허용하는 보안 그룹
- EC2 인스턴스 : 기본 설정으로 EC2 인스턴스를 t2.medium 타입으로 생성

**[ 적용 방법 ]**
```bash
# 필요한 프로바이더와 플러그인을 초기화
terraform init

# 실행 계획을 확인하여 리소스들이 올바르게 설정될지 미리 확인
terraform plan

# 인프라를 실제로 생성
teeraform apply
```
<br/>

### 3️⃣ Docker

애플리케이션을 위한 Dockerfile을 포함하고 있습니다.
- 멀티 스테이지 빌드 : 각 애플리케이션은 멀티 스테이지 Docker 빌드를 사용하여 빌드 단계와 런타임 단계를 분리하여 최종 이미지의 크기를 최소화합니다.
- 최소화된 런타임 환경 : 최종 이미지는 런타임 환경만 포함하여 배포에 필요한 최소한의 구성만을 포함합니다.
- 효율적인 의존성 관리 : 빌드 과정에서 의존성 파일을 설치하고, 이를 런타임 환경으로 복사하여 불필요한 의존성을 배제합니다.

**[ 적용 방법 및 명령어 ]**
```bash
# Docker 이미지 빌드
docker build -t <image-name> .

# Docker 컨테이너 실행
docker run -p <host_port>:<container_port> <image-name>

# 실행 중인 Docker 컨테이너 확인
docker ps

# 실행 중인 Docker 컨테이너 종료
docker stop <container_name>
```
<br/>

### 4️⃣ Kustomize
 **Kubernetes(Kustomize)** 를 사용하여 애플리케이션을 배포하는 방법을 설명합니다.
 
- **Kustomize 환경 구성**
  - `base/` : 기본 리소스 (Deployment, Service 등)
  - `overlays/dev/` : 개발 환경을 위한 patch
  - `overlays/prod/` : 운영 환경을 위한 patch
- **Ingress 설정**
  - `nginx/ingress.yml` : 개발 환경 Ingress 설정
  - `ingress/alb.yml` : 운영 환경 ALB Ingress 설정

**[ 적용 방법 ]**

설정 적용 및 업데이트
```bash
# dev 환경 배포
kubectl apply -k overlays/dev

# prod 환경 배포
kubectl apply -k overlays/prod
```

배포 삭제
```bash
# dev 환경 삭제
kubectl delete -k overlays/dev  

# prod 환경 삭제
kubectl delete -k overlays/prod
```
