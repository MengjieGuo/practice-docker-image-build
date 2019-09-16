# 更新部署环境
# web server 部署工具 gunicorn 及其依赖
# 托管工具 circus 及其依赖

# 制作命令
# docker build -t registry.cn-hangzhou.aliyuncs.com/mengjieguo/through_ban:19.09.15_download .

# 推送：这是下载依赖的临时镜像，不推送


FROM registry.cn-hangzhou.aliyuncs.com/mengjieguo/through_ban:19.09.15

ADD requirements.txt .
RUN pip download -d /opt/pip_packages/ -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# pip install --no-index --find-links=/opt/pip_packages/ -r requirements.txt

