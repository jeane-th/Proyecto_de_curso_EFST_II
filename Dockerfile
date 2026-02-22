FROM tomcat:10.1-jdk21

COPY dist/PF_LDP1_AprendeYa.war /usr/local/tomcat/webapps/ROOT.war
COPY lib/mysql-connector*.jar /usr/local/tomcat/lib/

EXPOSE 8080
CMD ["catalina.sh", "run"]
