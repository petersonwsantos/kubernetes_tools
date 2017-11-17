#!/bin/sh
FROM ubuntu:16.04

LABEL maintainer="peterson W Santos <opeterson@hotmail.com>"
LABEL kubectl.version="1.8.3"
LABEL tag="1.0"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qqy && apt-get install -qqy curl git golang && \
    mkdir -p /root/go/bin/{src,bin} && \
    echo "export  GOBIN=\"/root/go/bin\"" > ~/.bashrc && \
    echo "export GOPATH=\"/root/go/bin/src\"" > ~/.bashrc && \
    GOBIN="/root/go/bin" GOPATH="/root/go/bin/src"  /usr/bin/go get -u github.com/cloudflare/cfssl/cmd/cfssl && \
    GOBIN="/root/go/bin" GOPATH="/root/go/bin/src"  /usr/bin/go get -u github.com/cloudflare/cfssl/cmd/cfssljson && \
    cp -fv /root/go/bin/*  /usr/bin/ && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/ &&\
    apt-get install -f && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /command
