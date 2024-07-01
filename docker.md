## install docker
```sh
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## run iris
```sh
docker pull intersystems/irishealth-community:latest-em

docker run -d -p 52773:52773 --init --name iris intersystems/irishealth-community:latest-em
```

## Portal Address

http://207.148.28.9:52773/csp/sys/UtilHome.csp

## IRIS Terminal
```sh
# terminal
docker exec -it iris iris terminal IRIS
# halt h , exit
```

## Stop IRIS container when you don't need it:
```sh
# stop
docker stop iris
```

## for findtable
```sh
docker run --name iris -d --publish 1972:1972 --publish 52773:52773 containers.intersystems.com/intersystems/iris-community:2022.1.0.209.0 --check-caps false
```

## Codespaces
```sh
https://ominous-space-tribble-j99pq5wr7435774-52773.app.github.dev/csp/sys/UtilHome.csp
```