FROM openjdk:8

LABEL org.label-schema.schema-version = "1.0.0-rc.1"
LABEL org.label-schema.name = "java test app"
LABEL org.label-schema.description = "This was built on our Docker 101 training"
LABEL org.label-schema.vendor = "Jiri Kratochvil"

RUN useradd tomcat
WORKDIR /opt
RUN wget -q http://mirror.dkm.cz/apache/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.zip && \
    unzip -q apache-tomcat-8.5.37.zip && mv apache-tomcat-8.5.37 tomcat && \
	rm apache-tomcat-8.5.37.zip && chmod 755 /opt/tomcat/bin/*.sh && rm -rf /opt/tomcat/webapps/ROOT && \
	chown -R tomcat /opt
	
USER tomcat
EXPOSE 8080
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME=/opt/tomcat
ENV CATALINA_BASE=/opt/tomcat
# ENV CATALINA_OPTS='-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
ENV JAVA_OPTS='-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap'

COPY tomcat-greeting.war /opt/tomcat/webapps/ROOT.war 

ENTRYPOINT /opt/tomcat/bin/catalina.sh run

