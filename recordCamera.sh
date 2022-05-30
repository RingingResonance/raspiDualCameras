#!/bin/bash
#This script loops, combines seperate audio and video streams, and records 4K at a constant quality variable bitrate.
#Each file is 5 minutes long and about ~60MB.
#The script also deletes old files that are 3 or more days old.

for (( ; ; ))
do
  find /bigdrive/jarrett/shared/BIRDHOUSEstorage/Moose/* -mtime +3 -exec rm {} \;
  d=$(date +"y%Y-m%m-d%d-H%H-M%M")
  ffmpeg -t 00:05:00 -i rtsp://birdhouse:9092/ -t 00:05:00 -i rtsp://admin:password@192.168.1.64:9090/ \
  -pass 1 -acodec mp3 -vcodec libx264 -r 15 -s 3840x2160 -c:v libx264 -crf 23 -maxrate 2M -bufsize 2M -threads 0 \
  -map 0:a -map 1:v -metadata title="Moose-$d" -y /path/to/cameraStorage/Moose/Moose-$d.mp4
done
