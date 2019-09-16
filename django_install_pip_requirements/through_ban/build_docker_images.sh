#!/bin/bash

echo "镜像构建脚本"
sleep 0.5
echo "需要在目录下准备或者替换文件：requirements.txt"
echo "requirements.txt文件中请放增量的依赖，不要放所有依赖，因为在生产环境只上传pip依赖的包，为了减少文件大小，需要使用Download 和 install方式在生产环境制作镜像。当然本地使用的是直接install"
sleep 0.5
echo "应为当前只有一个版本的Dockerfile，所有如果需要，准备或者替换文件：Dockerfile"
sleep 0.5

echo "请在该文件所在目录下运行命令行：bash build_docker_images.sh 基础镜像名称 190915 my_image_name"
echo "默认为阿里云自建仓库：registry.cn-hangzhou.aliyuncs.com/mengjieguo/，所以只需给出仓库后面的名字"
echo "默认情况会删除构建镜像的目录，如果想保留，请传递第四个命令行参数 为任意值"
echo -e "\n"

sleep 3

# 此脚本用来自动构建镜像
# 当前基础镜像为 Alpine_base （自封装基础镜像，无pip依赖，修复了时区问题）

# 需要给出要构建的镜像的dockerfile文件的目录名和 要构建的镜像的名称

current_dir=$(pwd)

# 参数数量检查
echo -n '检查命令行参数 ... '
sleep 1
if [[ -n $1 ]] && [[ -n $2 ]] && [[ -n $3 ]]; then
    echo "OK"
else
    echo "Failure"
    sleep 1
    echo "第一个参数：依赖的镜像；第二个参数：构建镜像的目录名称；第三个参数：要构建的镜像的名称"
    exit
fi


# 构建镜像是的 依赖的镜像的名称，如果不存在，就是使用默认值
if [[ -n $1 ]]; then
    base_image="$1"
else
    echo "基础镜像名称必须指定，"
    base_image=""
    exit
fi

# 要构建镜像的 dockerfile 目录的名称
dockerfile_dir_name="$2_direct_install"

# 要构建镜像的 名称, 默认值 为 "$1_direct_install"，可以通过命令行覆盖
if [[ -n $3 ]]; then
    docker_image_name="$3"
else
    docker_image_name="$2_direct_install"
fi

echo "将从基础镜像开始封装:  $base_image"
sleep 0.5
echo "将创建制作镜像的目录: $dockerfile_dir_name"
sleep 0.5
echo "将构建的镜像的名称: $docker_image_name"

sleep 0.5

# 环境准备

# - 将创建制作镜像的目录
echo -n '将创建制作镜像的目录 ... '
sleep 0.5
mkdir ${dockerfile_dir_name}
if [[ "$?" == "0" ]];then
    echo ' OK'
    echo ' '
else
    echo ' FAILURE'
     exit 1
fi


echo -n "准备 Dockerfile 文件 ... "
sleep 0.5
cp Dockerfile ${dockerfile_dir_name}
if [[ "$?" == "0" ]];then
    echo ' OK'
    echo ' '
else
    echo ' FAILURE'
     exit 1
fi
echo -n "准备 requirements.txt 文件 ... "
sleep 0.5
cp requirements.txt ${dockerfile_dir_name}
if [[ "$?" == "0" ]];then
    echo ' OK'
    echo ' '
else
    echo ' FAILURE'
    exit 1
fi

# 默认使用 download 和 install 方式, 可以更改为直接 install 模式

# 两种模式的区别
# 一个是先下载依赖，然后从依赖中安装
# 另一个是直接下载并安装

# 构建命令 - 带参数

echo -n "进入构建镜像的目录 ${dockerfile_dir_name}"
sleep 0.5
cd ${dockerfile_dir_name}
if [[ "$?" == "0" ]];then
    echo ' OK'
    echo ' '
else
    echo ' FAILURE'
    exit 1
fi

# 可以使用 sed 做文本替换操作
# --build-arg BASE_DOCKER_IMAGE_NAME=${base_image}

# docker build -t container_tag --build-arg MYAPP_IMAGE=localimage:latest .
echo -n "开始制作镜像, 将运行命令："
echo "docker build -t registry.cn-hangzhou.aliyuncs.com/mengjieguo/${docker_image_name}  --build-arg MYAPP_IMAGE=registry.cn-hangzhou.aliyuncs.com/mengjieguo/${base_image} ."
echo -e '\n'
sleep 0.5

docker build -t "registry.cn-hangzhou.aliyuncs.com/mengjieguo/${docker_image_name}"  --build-arg MYAPP_IMAGE="registry.cn-hangzhou.aliyuncs.com/mengjieguo/${base_image}" .
if [[ "$?" == "0" ]];then
    echo ' OK'
    echo ' '
else
    echo ' FAILURE'
    exit 1
fi

if [[ -n $4 ]]; then
    echo "不清理构建镜像的目录"
else
    echo  -n "清理目录 ${dockerfile_dir_name} ... "
    sleep 0.5
    cd ${current_dir}
    rm -rf ${dockerfile_dir_name}
    if [[ "$?" == "0" ]];then
        echo ' OK'
        echo ' '
    else
        echo ' FAILURE'
        exit 1
    fi
fi





