docker network create jenkins

docker volume create jenkins-data
docker volume create jenkins-docker-certs

docker container run --name jenkins-docker \
  --detach --restart unless-stopped \
  --privileged \
  --network jenkins --network-alias docker \ 
  --env DOCKER_TLS_CERTDIR="/certs" \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  docker:dind
