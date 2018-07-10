from ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt -y upgrade && \
    apt install -y make
    apt-get autoremove -y && \
    apt-get clean

ADD IOC /usr/local/IOC
