# Build NodeJS image more easy

## Feature

* Centos 7
* nodejs 7.10.0
* pm2-docker
* pm2-logrotate

## Build your image base on `pm2-docker`

example: https://github.com/shanelau/pm2-docker/tree/master/pm2-build-test

### 1. Create Dockerfile

```
FROM shanelau/pm2-docker:latest
```

### 2. Create pm2 config file `process.yml`

```
apps:
  - script   : './app.js'
    instances: 1
    exec_mode: 'cluster'
    log_date_format: 'YYYY-MM-DD HH:mm Z'
    out_file : 'logs/out.log'
    error_file: 'logs/err.log'
```

### 3. Docker build

```
docker build -t your_app_image .
```

### Run app

```
docker run -itd -p 3000:3000 --name app your_app_image
```
### then

```
curl http://127.0.0.1:3000
```

## Actions

Monitoring CPU/Usage of each process
$ docker exec -it <container_id> pm2 monit
Listing managed processes
$ docker exec -it <container_id> pm2 list
Get more information about a process
$ docker exec -it <container_id> pm2 show <app_name>
0sec downtime reload all applications
$ docker exec -it <container_id> pm2 reload all