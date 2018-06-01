# zs-jenkins

## zs-jenkins的拉取地址

```shell
#node版本为10.x
$ docker pull shuoer/zs-jenkins

#如果您没有配置镜像加速，没问题，我为你提供了阿里云的镜像拉取地址
$ docker pull registry.cn-hangzhou.aliyuncs.com/shuoer/zs-jenkins
```

## zs-jenkins 为您提供了不同node版本的镜像

例如：支持的node版本有(10、9、8、7、6)，不同node版本的镜像拉取地址
```shell
#node版本默认为10.x
$ docker pull shuoer/zs-jenkins

#node版本为9.x
$ docker pull shuoer/zs-jenkins:node9

#node版本为8.x
$ docker pull shuoer/zs-jenkins:node:8

#node版本为7.x
$ docker pull shuoer/zs-jenkins:node7

#node版本为6.x
$ docker pull shuoer/zs-jenkins:node6
```
### 启动zs-jenkins
```shell
docker run \
    -d \
    --rm \
    -p 8080:8080 \
    -p 50000:50000 \
    -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai \
    -v "$PWD/jenkins_home":/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name zs-jenkins \
    shuoer/zs-jenkins
```
启动命令有点多，没关系我提供了完整的启动shell脚本，将下面脚本保存为 `start.sh` 启动就可以 `sh start.sh`

```shell
DOCKER_NAME=zs-jenkins
DOCKER_TAG=latest
#提供两种下载镜像的方式
#   1.阿里云镜像服务（为国内的网速提供坚实的后盾）
#   2.docker官方的hub（翻墙方便的同学还是用官方吧😂）
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