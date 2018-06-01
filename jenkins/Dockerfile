#--------------------------------------------
# author：烁儿
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
FROM jenkins
MAINTAINER shuoer 690515591@qq.com
USER root
SHELL ["/bin/bash", "-c"]
ARG NODE_VERSION=10
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash && \
    apt-get install -y nodejs && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g yarn && \
    curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz && \
    tar zxvf docker-latest.tgz && \
    cp docker/docker /usr/local/bin/ && \
    rm -rf docker docker-latest.tgz
ARG DOCKER_GID=999 
ARG DOCKER_PORT=8080
USER root:${DOCKER_GID}
EXPOSE ${DOCKER_PORT}