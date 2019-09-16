# 更新部署环境
# web server 部署工具 gunicorn 及其依赖
# 托管工具 circus 及其依赖

# 制作命令
# docker build -t registry.cn-hangzhou.aliyuncs.com/mengjieguo/through_ban:19.09.15_install .

# 推送命令
#
# 如果推送不成功也可以已根据 Dockerfile 直接构建, 目录 ****_direct_install
#
# docker push registry.cn-hangzhou.aliyuncs.com/mengjieguo/through_ban:19.09.15_install


FROM registry.cn-hangzhou.aliyuncs.com/mengjieguo/through_ban:19.09.15

ADD requirements.txt .
ADD pip_packages.tar.gz /opt/
RUN pip install --no-index --find-links=/opt/pip_packages/ -r requirements.txt \
    && rm -rf /opt/pip_packages/
