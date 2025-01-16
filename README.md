## Infra Boilerplate Repository
이 레포지토리는 Docker, Kubernetes 매니페스트, Jenkins 파이프라인 스크립트, Terraform 코드와 같은 인프라 설정 및 관리를 위한 보일러플레이트 코드를 제공합니다. 
이 레포지토리는 DevOps 및 클라우드 인프라를 빠르고 효율적으로 구축하기 위해 설계되었습니다.

---
### 주요 특징

**1. Jenkins**

CI/CD 파이프라인을 구현하기 위한 Jenkinsfile 제공.
- GitHub 저장소에서 소스 코드 체크아웃.
- 기존 Docker 이미지 정리 및 새로운 이미지 빌드.
- 빌드된 Docker 이미지를 AWS Elastic Container Registry(ECR)에 푸시.
- Kubernetes 매니페스트 파일의 이미지 태그 자동 업데이트.
- Discord 웹훅을 통해 빌드 상태 알림 전송.

