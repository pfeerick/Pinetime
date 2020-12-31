FROM gitpod/workspace-full

ARG DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get update -qq \
    && sudo apt-get install -y \
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
# aarch64 packages
      libffi-dev \
      libssl-dev \
      python3-dev \ 
    && sudo rm -rf /var/cache/apt/* /var/lib/apt/lists/*;

# Needs to be installed as root
RUN sudo pip3 install adafruit-nrfutil

RUN sudo chown -R gitpod /opt

COPY docker/build.sh /opt/
# Lets get each in a separate docker layer for better downloads
# GCC
RUN bash -c "source /opt/build.sh; GetGcc;"
# NrfSdk
RUN bash -c "source /opt/build.sh; GetNrfSdk;"
# McuBoot
RUN bash -c "source /opt/build.sh; GetMcuBoot;"

# Link the default checkout workspace in to the default $SOURCES_DIR
RUN sudo ln -s /workspace/Pinetime /sources
