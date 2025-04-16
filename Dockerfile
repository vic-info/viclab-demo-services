# 构建阶段
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 运行阶段
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# 设置数据库连接环境变量
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/demo_db
ENV SPRING_DATASOURCE_USERNAME=demo_user
ENV SPRING_DATASOURCE_PASSWORD=demo_pass
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=none
ENV SPRING_JPA_SHOW_SQL=true
ENV SPRING_JPA_PROPERTIES_HIBERNATE_FORMAT_SQL=true

# 暴露端口
EXPOSE 8081

# 启动命令
ENTRYPOINT ["java","-jar","/app/app.jar"] 