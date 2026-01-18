# 构建阶段
FROM maven:3.9.9-amazoncorretto-17 AS build

WORKDIR /app

# 先复制 pom.xml 利用 Docker 缓存层
COPY pom.xml .

# 下载依赖（利用缓存）
RUN mvn dependency:go-offline -B

# 复制源代码
COPY src ./src

# 使用 Maven 构建项目
RUN mvn -B clean package -DskipTests

# 运行阶段 - 使用 Eclipse Temurin (更可靠的镜像源)
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# 创建上传文件目录
RUN mkdir -p /app/uploads

# 将构建产物复制到运行镜像
COPY --from=build /app/target/*.jar app.jar

# 设置时区
ENV TZ=Asia/Shanghai
RUN apk add --no-cache tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# 暴露端口
EXPOSE 8080

# 设置启动命令，默认使用 docker 配置
ENTRYPOINT ["java", "-jar", "app.jar"]
CMD ["--spring.profiles.active=docker"]
