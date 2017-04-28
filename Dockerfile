FROM centos:7
ENV LANG en_US.UTF-8
ENV TZ Asia/Shanghai
ENV APP_ENV docker
ENV NODE_ENV docker
ENV NODE_VERSION 6.10.2
RUN yum install -y wget && \
  wget -qO-  http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | tar zxv

ENV PATH /node-v$NODE_VERSION-linux-x64/bin:$PATH

RUN npm config set registry https://registry.npm.taobao.org && \
npm install -g pm2 && \
pm2 install pm2-logrotate && \
pm2 set pm2-logrotate:max_size 10M && \
pm2 set pm2-logrotate:compress true && \
pm2 set pm2-logrotate:rotateInterval '0 2 * * *'

ENV PATH /node-v$NODE_VERSION-linux-x64/lib/node_modules/pm2/bin:$PATH

ENTRYPOINT ["pm2-docker"]