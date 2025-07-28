FROM ubuntu:22.04
LABEL maintainer="avan"

# Credit: https://github.com/spiretf/docker-tf2-server/blob/master/Dockerfile
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
	&& echo steam steam/license note '' | debconf-set-selections \
	&& apt-get -y update \
    && apt-get -y install curl \
	&& apt-get -y install software-properties-common \
	&& add-apt-repository multiverse \
	&& dpkg --add-architecture i386 \
	&& apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install libstdc++6 libcurl3-gnutls wget libncurses5 bzip2 unzip vim nano lib32gcc-s1 lib32stdc++6 steamcmd  \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		ca-certificates \
		lib32z1 \
		libncurses5:i386 \
		libbz2-1.0:i386 \
		libtinfo5:i386 \
		libcurl3-gnutls:i386 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& useradd -m tf2 \
	&& su tf2 -c '/usr/games/steamcmd +quit'

USER tf2

ENV USER=tf2
ENV HOME=/home/$USER
ENV SERVER=$HOME/hlserver

# ENV
ENV HOSTNAME="" \
    MGE_MAP="" \
    SV_PASSWORD="" \
    RCON_PASSWORD="" \
    SV_DOWNLOADURL="" \
    SB_WEBHOOK="" \
    TV_NAME=""

ENV DB_SB_HOST="" \
    DB_SB_PORT="3306" \
    DB_SB_NAME="" \
    DB_SB_USR="" \
    DB_SB_PW=""

ENV DB_MGE_HOST="" \
    DB_MGE_PORT="3306" \
    DB_MGE_NAME="" \
    DB_MGE_USR="" \
    DB_MGE_PW=""

ADD --chown=tf2:tf2 tf2_ds.txt cleanimage.sh cleandemo.sh update.sh mge.sh runtime.sh tf.sh $SERVER/
RUN chmod +x $SERVER/cleanimage.sh \
    $SERVER/cleandemo.sh \
    $SERVER/update.sh \
    $SERVER/mge.sh \
    $SERVER/runtime.sh \
    $SERVER/tf.sh

ADD --chown=tf2:tf2 server.cfg $SERVER/tf2/tf/cfg/

RUN mkdir -p $SERVER/tf2 \
	&& ln -s /usr/games/steamcmd $SERVER/steamcmd.sh \
	&& $SERVER/update.sh \
	&& $SERVER/cleanimage.sh \
    && $SERVER/mge.sh

EXPOSE 27015/udp 27015/tcp 27021/tcp 27020/udp

WORKDIR /home/$USER/hlserver

ENTRYPOINT ["./tf.sh"]