FROM java:8-jre
MAINTAINER 朱志欧<zhuzhiou@qq.com>
ADD target/helloworld.jar /opt/helloworld.jar
RUN bash -c 'touch /opt/helloworld.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/opt/helloworld.jar"]