from ubuntu:18.04

RUN apt update && \
    apt -y upgrade && \
    apt install -y make python-pip g++ && \
    apt autoremove -y && \
    apt clean

RUN pip install --upgrade pip==9.0.3 && \
    pip install conan==1.0.2 && \
    rm -rf /root/.cache/pip/*

RUN conan profile new default

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/registry.txt" "/root/.conan/registry.txt"

ADD "https://raw.githubusercontent.com/ess-dmsc/docker-ubuntu18.04-build-node/master/files/default_profile" "/root/.conan/profiles/default"

COPY conanfile.txt /usr/local/conanfile.txt

RUN mkdir /opt/conan/

RUN conan install --build -s compiler=gcc -s compiler.version=7.2 /usr/local/conanfile.txt

ENV PATH $PATH:/root/.conan/data/epics/3.16.1-4.6.0-dm4/ess-dmsc/stable/build/fe0bef86efc52a677c97a3e5e15f8e24bf381fa2/base-3.16.1/bin/linux-x86_64/

ADD IOC /usr/local/IOC

EXPOSE 5064 5065
EXPOSE 5064/udp

RUN cd /usr/local/IOC/ && make

CMD cd /usr/local/IOC/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd
