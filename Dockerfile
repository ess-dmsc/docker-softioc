from ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt -y upgrade && \
    apt install --no-install-recommends -y make python-pip perl g++ && \
    apt autoremove -y && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip==9.0.3 && \
    pip install setuptools && pip install conan && \
    rm -rf /root/.cache/pip/* && \
    conan profile new default

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/registry.json" "/root/.conan/registry.json"

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/default_profile" "/root/.conan/profiles/default"

COPY conanfile.txt /usr/local/conanfile.txt

RUN mkdir /opt/conan/ && conan install --build -s compiler=gcc -s compiler.version=7.2 /usr/local/conanfile.txt

ENV PATH $PATH:/root/.conan/data/epics/3.16.1-4.6.0-dm4/ess-dmsc/stable/build/fe0bef86efc52a677c97a3e5e15f8e24bf381fa2/base-3.16.1/bin/linux-x86_64/

ADD IOC /usr/local/IOC

EXPOSE 5064 5065
EXPOSE 5064/udp

RUN cd /usr/local/IOC/ && make

CMD cd /usr/local/IOC/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd
