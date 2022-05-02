#!/bin/bash

echo "Waiting 1 minute before initializing cameras."
sleep 60

#Look for AV to USB Capture Device.
echo "Looking for suitable capture device for Thermal Field."
for n in {0..2}; 
do

   i=$(v4l2-ctl -D -d /dev/video$n | grep -c 'ID               : 0x00000001')
   echo $i
   if [ $i -eq 1 ];then
        break
   fi

done

  if [ $i -eq 1 ];then
	echo "Using Video Capture Device for Thermal Field: "
        echo /dev/video$n
        cvlc v4l2:///dev/video$n --sout '#transcode{vcodec=h264,vb=600,width=320,height=240,fps=15,acodec=none}:rtp{sdp=rtsp://:9091/}' &
  else
        echo "Could not find suitable capture device for Thermal Field."
  fi

#Use raspi's built-in camera for this one.
echo "Attempting to start Visual Field camera."
sh /home/pi/pivid.sh &
