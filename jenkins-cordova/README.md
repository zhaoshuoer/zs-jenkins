# zs-jenkins:cordova

### zs-jenkins  允许您在构建的时候指定node、Android、Android-build-tools的版本

例如：构建一个node版本为10.*的Jenkins
    Android的版本可用,逗号隔开安装多个，如：ANDROID_VERSIONS=android-19,android-25,android-26,android-26
```shell
docker build -t zs-jenkins:cordova --build-arg NODE_VERSION=10 ANDROID_VERSIONS=android-26 ANDROID_BUILD_TOOLS=26.0.2 .
```

### 启动
```shell
DOCKER_NAME=zs-jenkins
DOCKER_IMAGES_NAME=registry.cn-hangzhou.aliyuncs.com/shuoer/${DOCKER_NAME}
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