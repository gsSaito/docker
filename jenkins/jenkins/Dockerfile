FROM jenkins/jenkins:latest
LABEL maintainer="hexagrimoire@gmail.com"
USER root
RUN mkdir -p /var/jenkins_home@tmp
RUN ln -s /var/jenkins_home /opt/jenkins_home
RUN chown jenkins:jenkins /var/jenkins_home@tmp
USER jenkins
ADD id_rsa /var/jenkins_home/.ssh/id_rsa
