# Inbound agent - Debian
https://github.com/jenkinsci/docker-agent/blob/master/debian/Dockerfile

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV AGENT_WORKDIR=${AGENT_WORKDIR}