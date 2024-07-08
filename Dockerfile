# 基于官方OpenJDK镜像
FROM openjdk:8u102-jdk
 
# 指定维护者信息
LABEL maintainer="18307200213@163.com"
 
# 添加Maven参数以配置使用的JVM参数
ENV JAVA_OPTS="-Dspring.profiles.active=github-actions"
 
# 可以将工作目录设置为/app
WORKDIR /app
 
# 复制pom.xml和源代码
COPY ./pom.xml ./src /app/
 
# 使用Maven打包应用程序
RUN mvn package $JAVA_OPTS

RUN ll
 
# 设置工作目录为生成的jar文件
WORKDIR /app/target
 
# 应用程序名称
ENV APP_NAME=myspringboot-0.0.1-SNAPSHOT.jar
 
# 复制编译后的jar到工作目录
COPY ${APP_NAME} ./
 
# 暴露8080端口
EXPOSE 80
 
# 运行Java应用程序
CMD ["java", "-jar", "${APP_NAME}"]
