# Step 1: Gradle을 사용하여 애플리케이션 빌드
FROM gradle:8.10.2-jdk17 AS build

# 컨테이너 내 작업 디렉토리 설정
WORKDIR /app

# 소스 코드를 컨테이너로 복사
COPY . .

# 병렬 실행을 활성화하여 애플리케이션 빌드
RUN ./gradlew bootJar --no-daemon --parallel

# Step 2: 경량화된 런타임 이미지 생성
FROM openjdk:17-jdk-slim

# 컨테이너 내 작업 디렉토리 설정
WORKDIR /app

# 빌드 단계에서 생성된 JAR 파일을 복사
COPY --from=build /app/build/libs/*.jar app.jar

# 컨테이너에서 사용할 포트 설정 (Spring Boot 기본 포트 8080)
EXPOSE 8080

# Spring Boot 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=local"]