#!/bin/bash
#
# Sets up Jenkins environment to run in Docker containers with DinD (Docker in Docker) for agent creation.
# Code copied from https://www.jenkins.io/doc/book/installing/docker/

# Initialise Jenkins network.
docker network create jenkins

# Spin up DinD images.
docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 docker:dind --storage-driver overlay2

# Spin up main Jenkins agent.
docker run --name jenkins-blueocean --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  brewdict-jenkins-blueocean:1.1
