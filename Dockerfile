FROM ubuntu:20.04

# Container labels
LABEL maintainer="OoLunar"

ENV TERRARIA_VERSION=1405
ENV TZ=Etc/UTC

RUN mkdir -p /data/worlds /data/configs /data/scripts /data/logs /etc/terraria \
    && touch /data/configs/banlist.txt \
    && apt-get update \
    && apt-get install -y zip wget procps tmux tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \

WORKDIR /data

RUN ln -s /data/scripts/terraria_cli.sh /usr/local/bin/terraria_cli \
    && ln -s /root/.local/share/Terraria/ /data \
    && wget https://terraria.org/system/dedicated_servers/archives/000/000/039/original/terraria-server-$TERRARIA_VERSION.zip \
    && unzip -j -o terraria-server-$TERRARIA_VERSION.zip $TERRARIA_VERSION'/Linux/*' -d /etc/terraria \
    && rm terraria-server-$TERRARIA_VERSION.zip
    && chmod +x /data/scripts/docker-entrypoint.sh /data/scripts/terraria_cli.sh /usr/local/bin/terraria_cli /etc/terraria/TerrariaServer.bin.x86_64

ENTRYPOINT ["./scripts/docker-entrypoint.sh"]