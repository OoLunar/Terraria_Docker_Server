FROM ubuntu:20.04

# Container labels
LABEL maintainer="akmaslov-dev"

# Container args
# Current terraria server version
ARG TERRARIA_VERSION=1405

# Installing packages and dependences
# Also cleanup after installation
RUN apt-get update
RUN apt-get install -y zip \
    wget \
    procps \
    tmux \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setting timezone
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Creating folders and subfolders for project
RUN mkdir -p /terraria/world
RUN mkdir -p /terraria/config
RUN ln -s /root/.local/share/Terraria/ /terraria
WORKDIR /terraria

# Download URL for terraria server. Be careful because it can change
RUN wget https://terraria.org/system/dedicated_servers/archives/000/000/039/original/terraria-server-$TERRARIA_VERSION.zip
RUN unzip -j -o terraria-server-$TERRARIA_VERSION.zip $TERRARIA_VERSION'/Linux/*' -d /terraria
RUN rm terraria-server-$TERRARIA_VERSION.zip

# Adding project files
COPY docker-entrypoint.sh ./
COPY terraria_cli.sh /usr/local/bin/terraria_cli
RUN chmod +x docker-entrypoint.sh /usr/local/bin/terraria_cli /terraria/TerrariaServer.bin.x86_64

ENTRYPOINT ["./docker-entrypoint.sh"]