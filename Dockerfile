from ubuntu:18.04

ADD IOC /IOC/
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y make g++ perl libreadline7 libreadline-dev wget \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /epics/ && cd /epics/ \
    && wget --quiet https://epics.anl.gov/download/base/base-3.16.2.tar.gz -O EPICS.tar.gz \
    && wget --quiet https://sourceforge.net/projects/epics-pvdata/files/4.6.0/EPICS-CPP-4.6.0.tar.gz -O V4.tar.gz \
    && tar xzf EPICS.tar.gz \
    && tar xzf V4.tar.gz \
    && mv base-*/ base/ \
    && mv EPICS-CPP* v4/ \
    && rm EPICS.tar.gz V4.tar.gz \
    && cd /epics/base \
    && export EPICS_BASE=/epics/base/ \
    && export EPICS_HOST_ARCH='linux-x86_64' \
    && make \
    && cd /epics/v4/ \
    && sed -i 's/MODULES += exampleCPP/# MODULES += exampleCPP/g' Makefile \
    && make \
    && cd /IOC/ \
    && make \
    && apt-get remove -y --purge make g++ perl wget

EXPOSE 5064 5065 5064/udp 5075 5076 5075/udp

ENV PATH $PATH:/epics/base/bin/linux-x86_64/:/epics/v4/pvAccessCPP/bin/linux-x86_64/

CMD cd /IOC/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd

