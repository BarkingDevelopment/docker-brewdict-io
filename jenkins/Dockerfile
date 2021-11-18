FROM jenkins/jenkins:latest

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
ENV DOCKER_OPTS="-H tcp://docker:2376"

RUN mkdir ${CASC_JENKINS_CONFIG}
COPY --chown=jenkins:jenkins ./casc.yaml ${CASC_JENKINS_CONFIG}

COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
