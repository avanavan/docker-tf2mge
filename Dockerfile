FROM ghcr.io/matcha-bookable/docker-tf2-server:latest
LABEL maintainer="avan"

# ENV
ENV HOSTNAME="" \
    MGE_MAP="" \
    SV_PASSWORD="" \
    RCON_PASSWORD="" \
    SV_DOWNLOADURL="" \
    TV_NAME=""

ENV DB_SB_HOST="" \
    DB_SB_PORT="3306" \
    DB_SB_NAME="" \
    DB_SB_USR="" \
    DB_SB_PW="" \
    SB_WEBHOOK="" \
    SB_WEBSITE="" \
    SB_SERVERID=""

ENV DB_MGE_HOST="" \
    DB_MGE_PORT="3306" \
    DB_MGE_NAME="" \
    DB_MGE_USR="" \
    DB_MGE_PW=""

ADD --chown=tf2:tf2 cleandemo.sh update.sh mge.sh runtime.sh tf.sh server.cfg $SERVER/
RUN chmod +x $SERVER/cleandemo.sh \
    $SERVER/update.sh \
    $SERVER/mge.sh \
    $SERVER/runtime.sh \
    $SERVER/tf.sh

RUN mkdir -p $SERVER/tf2 \
	&& ln -s /usr/games/steamcmd $SERVER/steamcmd.sh \
    && $SERVER/mge.sh \
    && mv $SERVER/server.cfg $SERVER/tf2/tf/cfg/

EXPOSE 27015/udp 27015/tcp 27021/tcp 27020/udp

WORKDIR /home/$USER/hlserver

ENTRYPOINT ["./tf.sh"]