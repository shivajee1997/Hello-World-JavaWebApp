From tomcat
COPY  target/java-hello-world.war /usr/local/tomcat/webapps/
RUN echo '<Context docBase="../../webapps/java-hello-world.war"/>' > /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml
EXPOSE 8080
CMD ["catalina.sh", "run"]
