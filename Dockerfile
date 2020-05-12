FROM ubuntu:18.04

MAINTAINER Madhurendra Sachan <madhurendra@tikaj.com>

RUN apt-get update && \ 
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    sudo \
    curl \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 &&\
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    
ARG DEBIAN_FRONTEND=noninteractive  
RUN apt-get update && apt upgrade -y && curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install nodejs node-gyp -y && apt-get install -y \
    ruby \
    ruby-dev \
    zip \
    tar \
    make \
    gcc \
    wget \
    curl \
    cmake \
    python \
    python-dev \
    python-pip \
    python3 \
    python3-dev \
    python3-pip \
    git \ 
    ssh \
    rsync \
    php \
    php-dev \
    php-pear \
    php-curl \ 
    php-xml \
    docker-ce \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && npm set registry "https://npm.tik.co" \
    && npm i -g n sass \
 #   && n lts \
    && npm i -g yarn bower @tikaj/pkg terser uglify-js typescript ts-node \
    && npm cache clean --force \
    && yarn config set registry "https://npm.tik.co/" \
    && gem install jekyll bundler
    

RUN pip3 install pyyaml    

RUN export DOCKER_HOST="tcp://docker:2375/" && \
    export DOCKER_DRIVER="overlay2" && \
    export DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4) \
    && curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose \
    && chmod +x docker-compose \
    && mv docker-compose /usr/local/bin \
    && docker-compose version

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc \
    && mv ./mc /usr/local/bin \
    && chmod 777 /usr/local/bin 


RUN wget http://tikle.sites.tik.co/tikle-linux.tar.gz -O tikle.tar.gz &&\
   tar -xvf tikle.tar.gz && rm tikle.tar.gz &&\
   mv tikle /usr/local/bin/tikle && chmod a+rx /usr/local/bin/tikle


