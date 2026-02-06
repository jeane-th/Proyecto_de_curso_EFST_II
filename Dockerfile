FROM tomcat:9.0-jdk21

COPY dist/Proyecto_de_curso_EFST_II.war /usr/local/tomcat/webapps/ROOT.war

COPY lib/mysql-connector*.jar /usr/local/tomcat/lib/

EXPOSE 8080
CMD ["catalina.sh", "run"]
