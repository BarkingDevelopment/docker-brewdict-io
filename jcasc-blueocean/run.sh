#!/bin/bash
#
# Runs the jcasc-blueocean image in a Docker container.

docker run --name jcasc-blueocean --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-docker-certs:/certs/client:ro \
  jcasc-blueocean:1.1
