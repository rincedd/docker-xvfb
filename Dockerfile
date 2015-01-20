FROM ubuntu:latest
MAINTAINER Gerd Zschaler <gzschaler@googlemail.com>

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install wget xvfb supervisor

# Add Google to the apt-get source list
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install google-chrome-stable

ENV DISPLAY :99
CMD ["/usr/bin/supervisord"]