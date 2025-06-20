# Docker

## install docker

```sh
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## run iris

```sh
docker pull intersystems/irishealth-community:latest-em

docker run -d \
    --publish 1972:1972 \
    --publish 52773:52773 \
    --name iris \
    intersystems/irishealth-community:latest-em

docker update --restart unless-stopped your_container_name

docker pull containers.intersystems.com/intersystems/irishealth-community:latest-em
```

no: 不自动重启（默认）
always: 无论退出状态，始终重启
unless-stopped: 除非手动停止，否则始终重启
on-failure: 仅当容器非正常退出时重启

## IRIS Terminal

```sh
docker exec -it iris iris terminal IRIS
```

## Stop IRIS container when you don't need it:

```sh
docker stop iris
```

## Codespaces

```sh
https://ominous-space-tribble-j99pq5wr7435774-52773.app.github.dev/csp/sys/UtilHome.csp


http://207.148.28.9:52773/csp/sys/UtilHome.csp
```
