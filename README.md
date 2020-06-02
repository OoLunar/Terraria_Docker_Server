# Terraria vanilla docker server


## Project requirements

* Docker

* Docker-compose


## Configuration

1. You need to create `config.txt` file inside `config` directory. See example below or [here](https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file). Please do not edit paths for `world` and `worldpath`. You just need to modify `*.wld` filename(if needed).
    ```bash
    
    # See wiki for server configuration fparameters
    # https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file
  
    world=/terraria/world/Awesome_world.wld
    autocreate=1
    seed=AwesomeSeed
    worldname=Awesome_terraria_server
    worldpath=/terraria/world/
    difficulty=3
    maxplayers=16
    password=Awesome_password_here
    motd=Awesome MOTD here
    npcstream=0
    ```

2. If you already have a save file and you want to host it, just copy your `*.wld` file into `world` directory and modify `world` param of your `config.txt`


### Installation and running

1. Clone or copy this repo

2. Inside root project directory run:
    ```bash
   docker-compose up -d 
   ```

   
### How to send command to server

1. All console commands you can see [here](https://terraria.gamepedia.com/Server#List_of_console_commands)

2. Example usage:
    * Send your message to ingame chat:
    
       ```bash
       docker-compose exec app terraria_cli "say Hello!" 
       ```
