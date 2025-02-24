FROM ubuntu:22.04
MAINTAINER uli.hitzel@gmail.com
EXPOSE 8080 5901
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y xfce4 xfce4-terminal
RUN apt-get install -y novnc
RUN apt-get install -y tightvncserver websockify
RUN apt-get install -y wget net-tools wget curl chromium-browser firefox openssh-client git
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs
ENV USER root

COPY start.sh /start.sh
RUN chmod a+x /start.sh

RUN useradd -ms /bin/bash user
RUN mkdir /.novnc
RUN chown user:user /.novnc

RUN apt-get -y install gedit vim
USER user

WORKDIR /.novnc
RUN wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C $PWD
RUN mkdir /.novnc/utils/websockify
RUN wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C /.novnc/utils/websockify
RUN ln -s vnc.html index.html

WORKDIR /home/user

CMD ["sh","/start.sh"]
