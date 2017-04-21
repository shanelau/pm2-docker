FROM centos:latest
ENV LANG en_US.UTF-8
ENV TZ Asia/Shanghai
ENV APP_ENV docker
ENV NODE_ENV docker
ENV NODE_VERSION 6.10.2
RUN yum install -y \
  bzip2 \
  wqy-microhei-fonts.noarch \
  wqy-unibit-fonts.noarch \
  wqy-zenhei-fonts.noarch \
  wget && \
  wget -qO-  http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | tar zxv

ENV PATH /node-v$NODE_VERSION-linux-x64/bin:$PATH

RUN npm config set registry https://registry.npm.taobao.org && \
npm install -g pm2

ENTRYPOINT ["/node-v6.10.2-linux-x64/lib/node_modules/pm2/bin/pm2-docker"]