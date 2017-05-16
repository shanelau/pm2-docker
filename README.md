## Feature
* centos 7
* nodejs 7.10.0
* pm2-docker
* pm2-logrotate



## build your image base on `pm2-docker`

### 1. create Dockerfile

```
FROM shanelau/pm2:latest
ADD . /www
CMD ['process.yml']
```
### 2. create pm2 config file `process.yml `
```
apps:
  - script   : './app.js'
    instances: 1
    exec_mode: 'cluster'
    log_date_format: 'YYYY-MM-DD HH:mm Z'
    out_file : 'logs/pm2/out.log'
    error_file: 'logs/pm2/err.log'
```

### 3. docker build
```
docker build -t your_app_image .
```

## Dockerfile
```
FROM centos:7
ENV LANG en_US.UTF-8
ENV TZ Asia/Shanghai
ENV NODE_VERSION 7.10.0
RUN yum install -y wget && \
  wget -qO-  http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | tar zxv && \
  yum clean all

ENV PATH /node-v$NODE_VERSION-linux-x64/bin:$PATH

RUN npm config set registry https://registry.npm.taobao.org && \
npm install -g pm2 && \
pm2 install pm2-logrotate && \
pm2 set pm2-logrotate:max_size 100M && \
pm2 set pm2-logrotate:compress true && \
pm2 set pm2-logrotate:rotateInterval '0 2 * * *'

ENV PATH /node-v$NODE_VERSION-linux-x64/lib/node_modules/pm2/bin:$PATH

ENTRYPOINT ["pm2-docker"]
```