FROM ubuntu:latest
MAINTAINER Gerd Zschaler <gzschaler@googlemail.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install wget xvfb supervisor openjdk-7-jre-headless build-essential git

# Add Google to the apt-get source list
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

# NodeJS
RUN wget -q -O - "https://deb.nodesource.com/setup" | bash -
RUN apt-get update && apt-get -y install google-chrome-stable nodejs && npm -g install grunt-cli bower

VOLUME /var/log/supervisord

ENV DISPLAY :99
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]