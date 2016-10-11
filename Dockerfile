FROM python:2
MAINTAINER Joshua Russell-Buckland (joshua-russell-buckland.15@ucl.ac.uk)

RUN mkdir /bcmd

ADD . /bcmd

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Insall unzip to deal with ppswarm at later date and all compilers
RUN apt-get update && \
    apt-get install --assume-yes zip && \
    apt-get install --assume-yes gfortran

RUN pip install numpy \
    matplotlib \
    scipy \
    SALib && \
    easy_install openopt && \
    easy_install FuncDesigner && \
    easy_install DerApproximator && \
    easy_install SpaceFuncs

RUN wget http://www.norg.uminho.pt/aivaz/pswarm/software/PPSwarm_v1_5.zip -O \
    tmp.zip && \
    unzip tmp.zip -d /bcmd && \
    rm tmp.zip && \
    # incorrect python reference inside Pswarm make file. Use SED to amend
    sed -i 's/python2.5/python2.7/g' /bcmd/PPSwarm_v1_5/makefile && \
    sed -i 's/usr\/include\/python2.7/usr\/local\/include\/python2.7/g' \
    /bcmd/PPSwarm_v1_5/makefile && \
    sed -i 's/usr\/lib\/python2.7/usr\/local\/lib\/python2.7/g' \
    /bcmd/PPSwarm_v1_5/makefile && \
    cd /bcmd/PPSwarm_v1_5 && \
    make py && \
    cp pswarm_py.so /bcmd/batch/pylib/ && \
    cd ..

#set working directory to where bcmd files are
WORKDIR /bcmd
RUN ./autogen.sh && \
    ./configure && \
    make
CMD ["/bin/bash"]

# TODO dockerignore file
# TODO check directory structure and then mkdir
