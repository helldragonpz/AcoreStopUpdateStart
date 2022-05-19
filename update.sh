#!/bin/bash
script -a -e -c "set -x; echo this is logging ..;
"
time="360"   #time till server restart
delay="370"  #delay time so the server finish shutdowning successfully recomendet at least 10s
timetext="5 Mins"  #time in minutes
chat="Server will be down for 30 mins after shutdown for maintenance!" #inform your player that your server entering in maintancance!

############Realm - 1 Update##########
# send key to stop Realm1 - Blizzlike#
######################################
tmux send-keys -t world-session ".nameannounce $chat" ENTER \; 
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Aunnonce is not send!"
    fi
sleep 5
        echo "Notification for maintenance sent successfully!"

tmux send-keys -t world-session ".server shutdown $time" ENTER \;

        echo "Realm will shutdown after $timetext!"
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Realm2 is not shuting down check log files!"
    fi
{
  countdown=${1:-$time}   ## 360-second default (5mins)
  w=${#countdown}
  while [ $countdown -gt 0 ]
  do
    sleep 1 &
    printf "  %${w}d\r" "$countdown"
    countdown=$(( $countdown - 1 ))
    wait
  done
  printf "\a"
} 2>/dev/null

    sleep $delay
    tmux kill-session -t auth-session
	tmux kill-session -t world-session
        echo "Blizzlike realm sucksessfuly shutdown!"
sleep 2
cd /home/tanados/azerothcore-wotlk

	
git pull
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Git pull error check log files!"
    fi
sleep 5
        echo "Downloading updates for Blizzlike Realm!"
#Client data auto update
set -e
    ./acore.sh client-data
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Client Data update error check log files!"
    fi
sleep 5
        echo "Downloading Client Data updates for Blizzlike Realm!"
##############################
#Git Pull Modules auto update#
##############################
#Anticheat
cd /home/tanados/azerothcore-wotlk/modules/mod-anticheat

git pull
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Git pull error check log files!"
    fi
sleep 5
        echo "Downloading updates for Anticheat!"

#Multi Client Check
cd /home/tanados/azerothcore-wotlk/modules/mod-multi-client-check

git pull
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Git pull error check log files!"
    fi
sleep 5
        echo "Downloading updates for Multi Client Check!"

#Cmake Compiler
cd /home/tanados/azerothcore-wotlk
./acore.sh compiler build
    if [[ $? -ne 0 ]]; then
        exit $?
        echo "Build updates error check log files!"
    fi
sleep 5
        echo "Build updates finished!"

#Auto Start Server

./world.sh
    if [[ $? -ne 0 ]]; then
            exit $?
        fi
    sleep 30
echo "Blizzlike realm updated and started use 'tmux attach -t world-session!' to attach it!"

#Realm - 2 Auto Update
cd /home/tanados/world2

###############################
# send key to stop Realm2 - 5x#
###############################
tmux send-keys -t world-session2 ".nameannounce $chat" ENTER \;
 if [[ $? -ne 0 ]]; then
                        exit $?
                        echo "Aunnonce is not send!"
                fi
sleep 1
                        echo "Notification for maintenance sent successfully!"

tmux send-keys -t world-session2 ".server shutdown $time" ENTER \;

        echo "Realm will shutdown after $timetext!"
	if [[ $? -ne 0 ]]; then
        exit $?
        echo "Realm2 is not shuting down check log files!"
        fi
{
  countdown=${1:-$time}   ## 360-second default (5mins)
  w=${#countdown}
  while [ $countdown -gt 0 ]
  do
    sleep 1 &
    printf "  %${w}d\r" "$countdown"
    countdown=$(( $countdown - 1 ))
    wait
  done
  printf "\a"
} 2>/dev/null

    sleep $delay

	tmux kill-session -t world-session2
        echo "Realm Zul 5x sucksessfuly shutdown!"

######################
#Git Pull Auto update#
######################
    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
           echo "Git pull error check log files!"
    fi
        sleep 5
        echo "Downloading updates for Zul  5x Realm!"
#########################
#Client data auto update#
#########################
set -e
    ./acore.sh client-data
    if [[ $? -ne 0 ]]; then
    exit $?
		echo "Client Data update error check log files!"
    fi
        sleep 5
			echo "Downloading Client Data updates for Zul 5x Realm!"
##############################
#Git Pull Modules auto update#
##############################
#Anticheat
cd /home/tanados/world2/modules/mod-anticheat

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Anticheat!"

#Eluna Engine
cd /home/tanados/world2/modules/mod-eluna

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Eluna Engine!"

#PVP Titles
cd /home/tanados/world2/modules/mod-pvp-titles

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for PVP Titles!"

#Auto Balance
cd /home/tanados/world2/modules/mod-autobalance

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Auto Balance!"
#GuildHouse
cd /home/tanados/world2/modules/mod-guildhouse

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for GuildHouse!"
#Reward Player Time
cd /home/tanados/world2/modules/mod-reward-played-time

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Reward Player Time	!"

#CFBG
cd /home/tanados/world2/modules/mod-cfbg

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for CFBG!"
#Auto Learn Spells
cd /home/tanados/world2/modules/mod-learn-spells

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Auto Learn Spells!"
#Transmog
cd /home/tanados/world2/modules/mod-transmog

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Transmog!"
#Weekend XP
cd /home/tanados/world2/modules/mod-weekend-xp

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Weekend XPt!"
#AH Bot
cd /home/tanados/world2/modules/mod-ah-bot

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for AH Bot!"
#Duel Reset
cd /home/tanados/world2/modules/mod-duel-reset

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Duel Reset!"

#Multi Client Check
cd /home/tanados/world2/modules/mod-multi-client-check

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for Multi Client Check!"
#WorGoblin
cd /home/tanados/world2/modules/mod-worgoblin

    git pull
    if [[ $? -ne 0 ]]; then
        exit $?
			echo "Git pull error check log files!"
    fi
		sleep 5
			echo "Downloading updates for WorGoblin!"  

################
#Cmake Compiler#
################
cd /home/tanados/world2
    ./acore.sh compiler build
    if [[ $? -ne 0 ]]; then
                exit $?
				echo "Build updates error check log files!"
    fi
    sleep 5
				echo "Build updates finished!"

#Auto Start Server

    ./world.sh
    if [[ $? -ne 0 ]]; then
            exit $?
        fi
    sleep 30
echo "Zul 5x realm updated and started use 'tmux attach -t world-session!' to attach it!"
"UpdateLog.log

