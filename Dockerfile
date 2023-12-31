FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
RUN git clone https://github.com/Barkha6/petclinicapp-demo.git
RUN cd petclinicapp-demo && mvn install

FROM tomcat:8-jre11

#remove default 
RUN rm -rf /usr/local/tomcat/webapps/*

#copy build 
#COPY --from=BUILD_IMAGE petclinicapp-demo/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=BUILD_IMAGE petclinicapp-demo/target/* /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
