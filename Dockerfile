FROM ubuntu:14.04
MAINTAINER Matthias Neugbauer <mtneug@mailbox.org>

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      perl ruby python subversion git-core wget curl bzip2 unzip xz-utils \
      binutils composite build-essential make patch gcc gcc-multilib g++ \
      \
      graphicsmagick autoconf automake autopoint automake1.9 libtool gettext \
      flex bison texinfo tofrodos pkg-config ecj fastjar realpath gawk \
      intltool \
      \
      libusb-dev libacl1-dev libcap-dev libc6-dev-i386 lib32ncurses5-dev \
      lib32stdc++6 libglib2.0-dev libattr1-dev libncurses5-dev libreadline-dev \
      libstring-crc32-perl zlib1g-dev

RUN useradd freetz \
 && mkdir -p /freetz/images \
 && chown -R freetz /freetz \
 && mkdir -p /patches \
 && chown -R freetz /patches

WORKDIR /freetz
USER freetz

VOLUME /freetz/images

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["build", "trunk"]
