# zs-jenkins
### zs-jenkins 允许您在镜像构建阶段指定node的版本
例如：构建一个node版本为10.*的Jenkins
```shell
docker build -t zs-jenkins --build-arg NODE_VERSION=10 .
```

例如：构建一个node版本为9.*的Jenkins
```shell
docker build -t zs-jenkins --build-arg NODE_VERSION=9 .
```

例如：构建一个node版本为8.*的Jenkins
```shell
docker build -t zs-jenkins --build-arg NODE_VERSION=8 .
```

例如：构建一个node版本为6.*的Jenkins
```shell
docker build -t zs-jenkins --build-arg NODE_VERSION=6 .
```
### 启动zs-jenkins
```shell
DOCKER_NAME=zs-jenkins
DOCKER_TAG=latest
#提供两种下载镜像的方式
#   1.阿里云镜像服务（为国内的网速提供坚实的后盾）
#   2.docker官方的hub（翻墙方便的同学还是用官方吧😂）
# DOCKER_IMAGES_NAME=registry.cn-hangzhou.aliyuncs.com/shuoer/${DOCKER_NAME}
DOCKER_IMAGES_NAME=shuoer/${DOCKER_NAME}
#如果当前容器正在运行，干掉
if [ $(docker ps -a | grep -c $DOCKER_NAME) -ge 1 ]; then
    docker rm -f ${DOCKER_NAME};
fi
# 如果当前本地镜像列表中有，删掉
if [ $(docker images | grep -c ${DOCKER_IMAGES_NAME}) -ge 1 ]; then
    docker rmi -f ${DOCKER_IMAGES_NAME};
fi
docker run \
    -d \
    --rm \
    -p 8080:8080 \
    -p 50000:50000 \
    -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai \
    -v "$PWD/jenkins_home":/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name ${DOCKER_NAME} \
    ${DOCKER_IMAGES_NAME}:${DOCKER_TAG}
```

#zs-jenkins的cordova TAG
### zs-jenkins  允许您在构建的时候指定node、Android、Android-build-tools的版本

例如：构建一个node版本为10.*的Jenkins
    Android的版本可用,逗号隔开安装多个，如：ANDROID_VERSIONS=android-19,android-25,android-26,android-26
```shell
docker build -t zs-jenkins:cordova --build-arg NODE_VERSION=10 ANDROID_VERSIONS=android-26 ANDROID_BUILD_TOOLS=26.0.2 .
```

### 启动
```shell
DOCKER_NAME=zs-jenkins
# DOCKER_IMAGES_NAME=registry.cn-hangzhou.aliyuncs.com/shuoer/${DOCKER_NAME}
DOCKER_IMAGES_NAME=shuoer/${DOCKER_NAME}
DOCKER_TAG=cordova
#如果当前容器正在运行，干掉
if [ $(docker ps -a | grep -c $DOCKER_NAME) -ge 1 ]; then
    docker rm -f ${DOCKER_NAME};
fi
# 如果当前本地镜像列表中有，删掉
if [ $(docker images | grep -c ${DOCKER_IMAGES_NAME}) -ge 1 ]; then
    docker rmi -f ${DOCKER_IMAGES_NAME}:${DOCKER_TAG};
fi
#运行
docker run \
    -d \
    --rm \
    -p 8080:8080 \
    -p 50000:50000 \
    -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai \
    -v "$PWD/jenkins_home":/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name ${DOCKER_NAME} \
    ${DOCKER_IMAGES_NAME}:${DOCKER_TAG}
```
