#!/bin/bash

#Start Thermal Camera.
/home/pi/netCam.sh &
sleep 5
#Wait 5 seconds for it to startup, then increase priority.
PID=$(pgrep --newest vlc)
sudo renice -n -20 -p $PID
sleep 2
#start Visual Camera.
/home/pi/pivid.sh &
sleep 5
#Wait 5 seconds for it to startup, then increase priority.
PID=$(pgrep --newest vlc)
sudo renice -n -20 -p $PID
PID=$(pgrep --newest raspivid)
sudo renice -n -20 -p $PID