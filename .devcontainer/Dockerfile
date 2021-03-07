FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
    && apt-get install -y \
# x86_64 / generic packages
      bash \
      build-essential \
      cmake \
      git \
      make \
      python3 \
      python3-pip \
      tar \
      unzip \
      wget \ 
      curl \
      dos2unix \
      clang-format \
      clang-tidy \
# aarch64 packages
      libffi-dev \
      libssl-dev \
      python3-dev \ 
      rustc \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*;

RUN pip3 install adafruit-nrfutil
RUN pip3 install -Iv cryptography==3.3

WORKDIR /opt/
# build.sh knows how to compile
COPY build.sh .

# Lets get each in a separate docker layer for better downloads
# GCC
RUN bash -c "source /opt/build.sh; GetGcc;"

# NrfSdk
RUN bash -c "source /opt/build.sh; GetNrfSdk;"

# McuBoot
RUN bash -c "source /opt/build.sh; GetMcuBoot;"

# create_build_openocd.sh uses cmake to create to build directory
COPY create_build_openocd.sh .

RUN adduser infinitime

ENV SOURCES_DIR /workspaces/InfiniTime
