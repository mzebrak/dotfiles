FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=0
ENV TZ="Europe/Warsaw"

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
      software-properties-common \
      gpg-agent \
      tzdata \
      sudo \
      git \
      make \
    && rm -rf /var/lib/apt/lists/*

RUN echo "Set disable_coredump false" >> /etc/sudo.conf

RUN adduser --disabled-password --gecos '' test && adduser test sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER test

COPY --chown=test:test . /home/test/dotfiles

ENV USER test

ENV PATH="/home/test/bin:${PATH}"

WORKDIR /home/test/dotfiles
