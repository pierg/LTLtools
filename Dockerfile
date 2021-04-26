FROM ubuntu:21.04

#RUN apt update && \
#    apt install -y software-properties-common && \
#    rm -rf /var/lib/apt/lists/*
#
#
#RUN add-apt-repository ppa:openjdk-r/ppa


RUN apt -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt -qq -y install \
#        g++ \
#        cmake \
#        make \
#        libboost-dev \
#        libboost-program-options-dev \
#        libboost-filesystem-dev \
#        libboost-iostreams-dev \
#        zlib1g-dev \
#        openjdk-13-jdk \
        unzip \
#        git \
        wget


# Copy repository with dependencies

RUN mkdir /home/crome/
COPY . /home/crome/

WORKDIR /home/crome/dependencies/ubuntu

## Install GraalVM and compile Strix from source
## Place graalvm-ce-java11-linux-amd64-21.1.0.tar.gz and strix_source.zip in /home/crome/dependencies/ubuntu
#RUN tar -xf graalvm-ce-java11-linux-amd64-21.1.0.tar.gz
#RUN unzip strix_source.zip
#RUN mv graalvm-ce-java11-21.1.0 java-11-graalvm
#RUN mv ./java-11-graalvm /usr/lib/jvm/
#RUN /usr/lib/jvm/java-11-graalvm/bin/gu install native-image
#WORKDIR /home/dependencies/ubuntu/strix
#RUN make

# Extract dependencies and install Strix and nuXmV
RUN unzip strix_bin.zip
RUN unzip nuXmv_bin.zip
RUN mv /home/crome/dependencies/ubuntu/bin/libowl.so /usr/bin
RUN mv /home/crome/dependencies/ubuntu/bin/strix /usr/bin

# Export Library
ENV LD_LIBRARY_PATH="/usr/bin"
RUN export LD_LIBRARY_PATH

# Copy Compiled NuXmv
RUN mv /home/crome/dependencies/ubuntu/nuXmv /usr/bin
RUN chmod +x /usr/bin/nuXmv


# Installing SPOT
RUN wget -q -O - https://www.lrde.epita.fr/repo/debian.gpg | apt-key add -
RUN echo 'deb http://www.lrde.epita.fr/repo/debian/ stable/' >> /etc/apt/sources.list

RUN apt -y update && DEBIAN_FRONTEND=noninteractive && \
    apt install -y \
    spot \
    libspot-dev \
    spot-doc


# Install CROME Dependencies
# Install Python 3
#RUN apt update \
#      && apt install -y python3-pip python3-dev \
#      && cd /usr/local/bin \
#      && ln -s /usr/bin/python3 python \
#      && pip3 --no-cache-dir install --upgrade pip \
#      && rm -rf /var/lib/apt/lists/*

#WORKDIR /home/crome
#
#RUN pip3 install -r requirements.txt
#
#ENV PYTHONPATH "${PYTHONPATH}:/home/crome/src"

CMD ["bash"]
