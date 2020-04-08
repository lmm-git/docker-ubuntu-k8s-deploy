FROM ubuntu:bionic

MAINTAINER Leonard Marschke <github@marschke.me>

# Set pythonunbuffered for getting better outputs in combination with GitLab CI
ENV PYTHONUNBUFFERED=1

# Set noninteractive environment
ENV DEBIAN_FRONTEND=noninteractive

# Set language environment to UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install build dependencies
RUN apt-get update \
# upgrade software
	&& apt-get -y upgrade \
	&& apt-get -y install apt-transport-https \
		ca-certificates \
		curl \
		software-properties-common \
# clean up
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Prepare kubectl installation
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
# clean up
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# update software repos
RUN apt-get update \
# upgrade software
	&& apt-get -y upgrade \
	&& apt-get -y install apt-utils \
# install some useful tools need to build grml (git is needed to use with gitlab ci)
	&& apt-get -y install \
# install essential build tools
		git \
# for envsubst
		gettext-base \
# kubectl
		kubectl \
# clean up
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
