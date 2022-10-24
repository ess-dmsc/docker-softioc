from ubuntu:18.04

ADD IOC /IOC/
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y make g++ perl libreadline7 libreadline-dev wget \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && wget --quiet https://epics.anl.gov/download/base/base-7.0.7.tar.gz \
    && tar xvzf base-7.0.7.tar.gz \
    && mkdir /opt/epics \
    && mv base-7.0.7 /opt/epics/base \
    && cd /opt/epics/base \
    && sed -i 's/DIRS += test/# DIRS += test/g' Makefile \
    && sed -i 's/SUBMODULES += example/# SUBMODULES += example/g' modules/Makefile \
    && cd /opt/epics/base && make \
    && cd /IOC/ \
    && make \
    && apt-get remove -y --purge make g++ perl wget

EXPOSE 5064 5065 5064/udp 5075 5076 5075/tcp 5076/udp

ENV PATH $PATH:/epics/base/bin/linux-x86_64/:/epics/v4/pvAccessCPP/bin/linux-x86_64/

CMD cd /IOC/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd

