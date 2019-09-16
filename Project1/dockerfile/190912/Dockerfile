# Docker build cmd
#   docker build -t tmp_office_system:19.09.12_Alpha .

# Docker push cmd


FROM python:3.6-alpine

RUN mkdir -p /home/project/code/app/
WORKDIR /home/project/code/app/
ADD requirements.txt .
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.6/main > /etc/apk/repositories \
    && echo http://mirrors.ustc.edu.cn/alpine/v3.6/community >> /etc/apk/repositories \
    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
#    && apk add --no-cache \
#    libffi-dev \
#    libcrypt-dev \
#    freetype-dev \
#    libjpeg-turbo-dev \
#    libpng-dev

    && pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

#pip download -d c:\program_x86\packages\ -r requirements.txt
#pip install --no-index --find-links=d:\python27\packages -r requirements.txt
