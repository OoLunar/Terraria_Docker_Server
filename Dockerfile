#TODO: Change ubuntu to alpine
FROM ubuntu:20.04

LABEL maintainer="Lunar Starstrum <lunar@forsaken-borders.net>"

# Source environment variables
ENV TERRARIA_VERSION="1405"
ENV TZ="Etc/UTC"

# Create local directory, prepare for volume mounting
RUN mkdir -p /data/ /etc/terraria /root/.local/share/
VOLUME /data
WORKDIR /data

# Install Terraria dependancies
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y zip wget procps tmux expect \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Download, unzip and fix file permissions
RUN wget https://terraria.org/system/dedicated_servers/archives/000/000/039/original/terraria-server-$TERRARIA_VERSION.zip \
    && unzip -j -o terraria-server-$TERRARIA_VERSION.zip $TERRARIA_VERSION'/Linux/*' -d /etc/terraria \
    && rm terraria-server-$TERRARIA_VERSION.zip

ENTRYPOINT ["/data/scripts/docker-entrypoint.sh"]