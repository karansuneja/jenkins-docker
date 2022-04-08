FROM jenkins/jenkins:2.319.3-jdk11


USER root
RUN groupadd -g 998 docker
RUN groupmod -g 998 docker
RUN usermod -aG docker jenkins

RUN apt-get update && apt-get install -y lsb-release
RUN apt-get install sudo

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli


USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"


