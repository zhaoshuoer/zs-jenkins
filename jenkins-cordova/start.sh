#--------------------------------------------
# author：烁儿
# slogan：学的不仅是技术，更是梦想！
#--------------------------------------------
DOCKER_NAME=zs-jenkins
DOCKER_IMAGES_NAME=registry.cn-hangzhou.aliyuncs.com/shuoer/${DOCKER_NAME}
# DOCKER_IMAGES_NAME=shuoer/${DOCKER_NAME}
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