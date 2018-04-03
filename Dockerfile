FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install locales

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# General things
RUN apt-get install -qq wget unzip build-essential cmake gcc libcunit1-dev libudev-dev

RUN apt-get install -qq  libcurl4-gnutls-dev

# Python things
RUN apt-get install -y python3 python3-dev python3-pip r-base

# Canu things
RUN apt-get install -y default-jre gnuplot

RUN pip3 install jupyter

# Grab the checked out source
RUN mkdir -p /work
WORKDIR /work

# Install canu
RUN wget https://github.com/marbl/canu/releases/download/v1.7/canu-1.7.Linux-amd64.tar.xz
RUN tar -xvf canu-1.7.Linux-amd64.tar.xz

# Install blast plus
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz
RUN tar -zxvf ncbi-blast-2.7.1+-x64-linux.tar.gz

CMD ["/usr/local/bin/jupyter", "notebook", "--port", "8888", "--ip", "0.0.0.0", "--allow-root"]