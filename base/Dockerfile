FROM ubuntu:21.04

RUN apt -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt -y install curl gnupg2

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN apt update && \
    apt install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*


RUN add-apt-repository ppa:openjdk-r/ppa


RUN apt -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt -qq -y install \
        g++ \
        cmake \
        make \
        libboost-dev \
        libboost-program-options-dev \
        libboost-filesystem-dev \
        libboost-iostreams-dev \
        zlib1g-dev \
        openjdk-13-jdk \
        gnupg2 \
        unzip \
        git \
        ca-certificates \
        wget


# Copy repository with dependencies

RUN mkdir /home/ltltools
COPY . /home/ltltools/

WORKDIR /home/ltltools/dependencies/ubuntu

# Install GraalVM and compile Strix from source
# Place graalvm-ce-java11-linux-amd64-21.1.0.tar.gz and strix_source.zip in /home/ltltools/dependencies/ubuntu
#RUN tar -xf graalvm-ce-java11-linux-amd64-21.1.0.tar
#RUN unzip strix_source.zip
#RUN mv graalvm-ce-java11-21.1.0 java-11-graalvm
#RUN mv ./java-11-graalvm /usr/lib/jvm/
#RUN /usr/lib/jvm/java-11-graalvm/bin/gu install native-image
#WORKDIR /home/ltltools/dependencies/ubuntu/strix
#RUN make

# Extract dependencies and install Strix and nuXmV
RUN unzip strix_bin_ubuntu_21_04.zip
RUN unzip nuXmv_bin.zip
RUN unzip NuSMV.zip
#RUN unzip spot-2.10.3.zip
RUN unzip spot-python-bindings.zip

RUN mv /home/ltltools/dependencies/ubuntu/bin/libowl.so /usr/bin
RUN mv /home/ltltools/dependencies/ubuntu/bin/strix /usr/bin

# Export Library
ENV LD_LIBRARY_PATH="/usr/bin"
RUN export LD_LIBRARY_PATH

# Copy Compiled NuXmv
RUN mv /home/ltltools/dependencies/ubuntu/nuXmv /usr/bin
RUN chmod +x /usr/bin/nuXmv

# Copy Compiled NuSMV
RUN mv /home/ltltools/dependencies/ubuntu/NuSMV /usr/bin
RUN chmod +x /usr/bin/NuSMV

RUN mv /home/ltltools/dependencies/ubuntu/ltl2smv /usr/bin
RUN chmod +x /usr/bin/ltl2smv

# Install Python 3
RUN apt update \
      && apt install -y python3-pip python3-dev \
      && cd /usr/local/bin \
      && ln -s /usr/bin/python3 python \
      && pip3 --no-cache-dir install --upgrade pip \
      && rm -rf /var/lib/apt/lists/*


## Installing SPOT
#WORKDIR /home/ltltools/dependencies/ubuntu/spot
#RUN ./configure
#RUN make && make check && make install



# Installing ANACONDA
# System packages
RUN apt-get update && apt-get install -yq curl wget jq vim
# Use the above args during building https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
# Install miniconda to /miniconda
RUN curl -LO "http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
RUN bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda




WORKDIR /home

RUN mkdir dependencies
RUN mkdir dependencies/spot
# RUN mv /home/ltltools/dependencies/ubuntu/spot/python/spot/* /home/dependencies/spot

RUN rm -r /home/ltltools

CMD ["bash"]
