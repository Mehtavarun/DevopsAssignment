FROM tomcat:alpine
MAINTAINER VarunMehta
ADD target/devopssampleapplication.war /usr/local/tomcat/webapps/devopssampleapplication.war
EXPOSE 6000
CMD /usr/local/tomcat/bin/catalina.sh run
