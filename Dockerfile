FROM debian:buster

ENV BUILD_PACKAGES \
 git \
 build-essential \
 bison \
 autoconf \
 automake \
 pkg-config \
 libevent-dev \
 libncurses-dev \
 ca-certificates

ENV CLEANUP_DIRECTORIES \ 
 ~/.cache/* \
 /var/cache/* \
 /var/log/* \
 /var/tmp/* \
 /tmp/*

RUN \
 echo " ----> Update system" \
 && apt-get update \
 && echo " ----> Install build packages" \
 && apt-get install --yes --no-install-recommends ${BUILD_PACKAGES} \
 && echo " ----> Cleanup" \
 && apt-get autoremove --yes \
 && apt-get autoclean --yes \
 && apt-get clean --yes \
 && rm --recursive --force ${CLEANUP_DIRECTORIES}

COPY build.sh /build/build.sh

WORKDIR /build
