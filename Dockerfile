FROM tomcat:alpine
MAINTAINER VarunMehta
ADD target/devopssampleapplication.war /usr/local/tomcat/webapps/devopssampleapplication.war
EXPOSE 6200
CMD /usr/local/tomcat/bin/catalina.sh run
