#!/usr/bin/env bash
##################
#     Configs    #
##################
[ -z $1 ] && time=300 || time=$1
[ $time -gt 60 ] && timetext="$((time / 60)) minutes" || timetext="1 minute"

chat="Server will be down for 30 mins after shutdown for maintenance!" #inform your player that your server entering maintenance!
world1="/root/wow" #directory to your main realm
world2="/root/wow2" #directory to your second realm
sleeptime="320" #shoud be $time + 20 seks
WEBHOOK="https://discord.com/api/webhooks/" #a discord configuration for WebHooks

modules_world1=(
#EDIT to your modules
  "$world1/modules/mod-anticheat"
  "$world1/modules/mod-multi-client-check"
)

modules_world2=(
#EDIT to your modules
  "$world2/modules/mod-account-achievements"
  "$world2/modules/mod-anticheat"
  "$world2/modules/mod-eluna"
  "$world2/modules/mod-pvp-titles"
  "$world2/modules/mod-autobalance"
  "$world2/modules/mod-guildhouse"
  "$world2/modules/mod-reward-played-time"
  "$world2/modules/mod-cfbg"
  "$world2/modules/mod-transmog"
  "$world2/modules/mod-weekend-xp"
  "$world2/modules/mod-ah-bot"
  "$world2/modules/mod-duel-reset"
  "$world2/modules/mod-multi-client-check"
)

# Function to send notification to the realm
send_notification_world() {
  tmux send-keys -t world ".nameannounce $chat" ENTER \; 
    if [[ $? -ne 0 ]]; then
        echo "Aunnonceis not send!"
        exit $?
    fi
    echo "Notification for maintenance sent successfully!"
}

send_notification_world2() {
  tmux send-keys -t world2 ".nameannounce $chat" ENTER \;
    if [[ $? -ne 0 ]]; then
        echo "Aunnonceis not send!"
        exit $?
    fi
    echo "Notification for maintenance sent successfully!"
}

# Function to update modules for the realm
update_modules_world() {
  for module in "${modules_world1[@]}"
  do
    cd $module
    git pull
    if [[ $? -ne 0 ]]; then
        echo "Git pull error, check log files!"
        exit $?
    fi
    echo "Downloading updates for $module"
  done
}

update_modules_world2() {
  for i in "${modules_world2[@]}"; do
    cd "$i"
    git pull
    if [[ $? -ne 0 ]]; then
        echo "Git pull error for module $(basename $i), check log files!"
        exit $?
    fi
    echo "Downloading updates for module $(basename $i)!"
  done
}

# Function to stop the realm
stop_realm_world() {
  tmux send-keys -t world ".server shutdown $time" ENTER \;
    if [[ $? -ne 0 ]]; then
        echo "Realm is not shutting down, check log files!"
        exit $?
    fi
    echo "Realm will shutdown after $timetext!"
     sleep_time=$sleeptime

# Start sleep in background process
sleep $sleep_time &
pid=$!

for ((i=1; i<=sleep_time; i++)); do
    percentage=$(( (i*100)/sleep_time ))
    printf "\rProgress: [%3d%%]" $percentage
    sleep 1
done

# Wait for sleep process to finish
wait $pid

# Continue with the script
echo "The script continues"
    tmux kill-session -t auth
    tmux kill-session -t world
    echo "Blizzlike realm successfully shutdown!"
}

stop_realm_world2() {
  tmux send-keys -t world2 ".server shutdown $time" ENTER \;
    if [[ $? -ne 0 ]]; then
        echo "Realm is not shutting down, check log files!"
        exit $?
    fi
    echo "Realm will shutdown after $timetext!"
    sleep_time=$sleeptime

# Start sleep in background process
sleep $sleep_time &
pid=$!

for ((i=1; i<=sleep_time; i++)); do
    percentage=$(( (i*100)/sleep_time ))
    printf "\rProgress: [%3d%%]" $percentage
    sleep 1
done

# Wait for sleep process to finish
wait $pid

# Continue with the script
echo "The script continues"
    tmux kill-session -t world2
    echo "Second realm successfully shutdown!"
}

###################
#      Logs       #
###################
current_date=$(date +%Y-%m-%d)
log_path="$HOME/wow/logs/" #Edit the Log folder "Need to be created beaufore you run the script"
log_file="$log_path/update-$current_date.log"
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec &> >(tee -a "$log_file") 2>&1

# Main script
send_notification_world
stop_realm_world
cd $world1
git pull
if [[ $? -ne 0 ]]; then
    echo "Git pull error, check log files!"
    exit $?
fi
echo "Downloading updates for Blizzlike realm!"
./acore.sh client-data
if [[ $? -ne 0 ]]; then
    echo "Client Data update error, check log files!"
    exit $?
fi
echo "Downloading Client Data updates for Blizzlike realm!"
update_modules_world
cd $world1
./acore.sh compiler build
if [[ $? -ne 0 ]]; then
    echo "Build updates error, check log files!"
    exit $?
fi
echo "Build updates finished!"
cd $world1
./start.sh

# Second realm updates
send_notification_world2
stop_realm_world2
cd $world2
git pull
if [[ $? -ne 0 ]]; then
    echo "Git pull error, check log files!"
    exit $?
fi
echo "Downloading updates for the second realm!"
./acore.sh client-data
if [[ $? -ne 0 ]]; then
    echo "Client Data update error, check log files!"
    exit $?
fi
echo "Downloading Client Data updates for the second realm!"
update_modules_world2
cd $world2
./acore.sh compiler build
if [[ $? -ne 0 ]]; then
    echo "Build updates error, check log files!"
    exit $?
fi
echo "Build updates finished!"
cd $world2
./start.sh
sleep 60
###############
##  DISCORD  ##
###############
cd ~/wow/discord
./discord.sh \
  --webhook-url=$WEBHOOK \
  --file $log_file \
  --username "The Watcher" \
  --text "This is an update for $current_date\nPlece take a look for errors!"

