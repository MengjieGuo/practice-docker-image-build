# 配合镜像构建脚本使用的Dockerfile
# 此Dockerfile制作镜像时使用的基础镜像如果需要连接oralce需要改变基础镜像


ARG MYAPP_IMAGE
FROM $MYAPP_IMAGE

ADD requirements.txt .
RUN pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/ \
    &&  rm -r /root/.cache
