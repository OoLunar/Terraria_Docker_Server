# Terraria Docker Server

## Note

Due to Docker issues, I'm archiving the repository. `docker-compose up` works until interactivity is required (when world needs to be generated). Untested with pregenerated worlds. NullReference Exception occurs when the world is not found, but specified in [data/configs/config.ini](data/configs/config.ini)

## Project requirements

- Docker
- (Optional, but recommended) docker-compose

## Configuration

1. Modify [data/configs/config.ini](data/configs/config.ini) as needed. The default values should do, however if you wish to change it, documentation can be found at their [wiki page](https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file).

2. If you have a world pre-generated, move it into the [`data/worlds/`](data/worlds/) folder. Make sure your worldname is the same as the `world` (not `worldname` or `worldpath`) setting in [data/configs/config.ini](data/configs/config.ini)

### Installation and running

1. Clone the repo.
2. Modify [data/configs/config.ini](data/configs/config.ini) as mentioned in [Configuration](#configuration)
3. Change file permissions of the scripts: `chmod 755 data/scripts/*`
4. Run `docker-compose up -d` in the terminal.

### How to send command to server

All console commands you can be found at their [wiki page](https://terraria.gamepedia.com/Server#List_of_console_commands).

1. Open up the terminal and navigate to the [data/scripts/](data/scripts/) folder.
2. Execute
    ```bash
    docker-compose exec terraria terraria_cli "say Hello!"
    ```
