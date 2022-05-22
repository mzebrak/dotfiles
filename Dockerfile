FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=0.0

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      sudo \
      build-essential \
      software-properties-common \
      keyboard-configuration && \
    apt-add-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
      git && \
    rm -rf /var/lib/apt/lists/*

RUN echo "Set disable_coredump false" >> /etc/sudo.conf

RUN adduser --disabled-password --gecos '' test && adduser test sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER test

COPY --chown=test:test . /home/test/dotfiles

ENV USER test

ENV PATH="/home/test/bin:${PATH}"

WORKDIR /home/test/dotfiles
