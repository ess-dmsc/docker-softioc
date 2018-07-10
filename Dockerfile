from ubuntu:18.04

RUN apt update && \
    apt -y upgrade && \
    apt install -y make python-pip && \
    apt autoremove -y && \
    apt clean

RUN pip install --upgrade pip==9.0.3 && \
    pip install conan==1.0.2 && \
    rm -rf /root/.cache/pip/*

RUN conan profile new default

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/registry.txt" "/root/.conan/registry.txt"

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/default_profile" "/root/.conan/profiles/default"

COPY conanfile.txt /usr/local/conanfile.txt

RUN conan install /usr/local/

ADD IOC /usr/local/IOC


