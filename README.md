# AcoreStopUpdateStart
This an small azerothcore stop/update/start script
If you run ./update.sh (or whatever you name it), it'll default to 300 seconds, if you run ./script.sh 900 for example it'll use 900 seconds instead.

## Install

### 1. Setting up a update.sh

1. Open it with your text editor
2. Edit configs 
```
1. chat="Server will be down for 30 mins after shutdown for maintenance!"  - inform your player that your server entering maintenance!

2. `[ -z $1 ] && time=300 || time=$1`
time - The time in seconds till servers get restart and updated

3. world1="/root/wow" #directory to your main realm
Edit directory of your first realm
world2="/root/wow2" #directory to your second realm
Edit directory of your second realm 

4. sleeptime="320" - need to >time with at least 20 seconds

5. WEBHOOK="https://discord.com/api/webhooks/12312461230105123761237"
WEBHOOK needed to send .log file to your discord server.

5. modules_world1=(
  "$world1/modules/mod-anticheat" - Edit to your modules folder
)
modules_world2=(
) - Same for the second realm

6. log_path="$HOME/wow/logs/" - Edit the path to your prefer location for storing update.logs 
```
3. Make your `update.sh` and `start.sh` runable by using `sudo chmod +x update.sh` and `sudo chmod +x start.sh` at a webhook endpoint (see below)
5. Use `crontab -e` and edit it to automate script. Here is an example: ` 0 4 * * 5 /usr/bin/env bash /root/wow/update.sh ` 

### 2. Specifying a Webhook URL within `discord.sh`

There are three ways to point `discord.sh` at a webhook endpoint, in order of priority that `discord.sh` takes:

1. Pass the webhook URL as an argument to `discord.sh` using `--webhook-url`
2. Set an environment variable called `$DISCORD_WEBHOOK`
3. Create a file called `.webhook` in the same directory as `discord.sh`, containing only the webhook URL

### 2. Use the script

# CREDITS:

Revision - tkn963 for helping improuve the code and great advices!

ChaoticWeg for - Creating discord.sh https://github.com/ChaoticWeg/discord.sh 

