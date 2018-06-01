FROM jenkins
MAINTAINER shuoer 690515591@qq.com
USER root
SHELL ["/bin/bash", "-c"]
ARG ANDROID_VERSIONS=android-26
ARG ANDROID_BUILD_TOOLS=26.0.2
ARG NODE_VERSION=10
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:/opt/gradle-4.1/bin
#用于干掉每次编译时总是从Google下载gradle编译工具
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL='https://code.aliyun.com/shuoer/soft/raw/master/gradle-4.1-all.zip'
#安装node、cordova环境
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash && \
    apt-get install -y nodejs && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g cordova && \
    npm install -g yarn && \
    curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz && \
    tar zxvf docker-latest.tgz && \
    cp docker/docker /usr/local/bin/ && \
    rm -rf docker docker-latest.tgz
WORKDIR /opt
#安装android环境
RUN wget https://downloads.gradle.org/distributions/gradle-4.1-bin.zip && \
    unzip gradle-4.1-bin.zip && \
    wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar zxvf android-sdk_r24.4.1-linux.tgz && \
    mkdir /root/.android && \
    touch /root/.android/repositories.cfg && \
    echo y | android update sdk \
        -a \
        --no-ui \
        --filter \
        tools,platform-tools,${ANDROID_VERSIONS},build-tools-${ANDROID_BUILD_TOOLS} && \
    rm -rf android-sdk_r24.4.1-linux.tgz && \
    rm -rf gradle-4.1-bin.zip
# 将 `jenkins` 用户的组 ID 改为宿主 `docker` 组的组ID，从而具有执行 `docker` 命令的权限。
ARG DOCKER_GID=999 
ARG DOCKER_PORT=8080
USER root:${DOCKER_GID}
EXPOSE ${DOCKER_PORT}