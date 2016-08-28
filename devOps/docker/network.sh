docker network create --driver bridge isolated_nw
docker network inspect isolated_nw

docker run --network=isolated_nw -itd --name=container3 busybox
