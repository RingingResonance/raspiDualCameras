#!/bin/bash
#This script is for the computer on the receiving end to combine multiple streams and then re-stream it or record it.
#It combines one main video stream, on overlay in the lower right corner, and an audio stream.

  ffmpeg -i rtsp://birdhouse:9092/ -i rtsp://birdhouse:9091/ -i rtsp://admin:thefish1234@192.168.1.64:9090/ \
  -pass 1 -acodec mp3 -vcodec libx264 -r 15 -s 1920x1080 -b:v 2M -maxrate 2M -bufsize 1M -threads 0 \
  -filter_complex "[1:v]scale=740:555[scaled],[2:v][scaled]overlay=3100:1605:shortest=1[out]" \
  -map [out] -map 0:a -f matroska - \
        | cvlc - \
        --h264-fps=15 \
        --sout-x264-keyint 5 \
        --sout-x264-non-deterministic 1 \
        --sout '#rtp{dst=0.0.0.0,port=1234,sdp=rtsp://:9090/}' :demux=264
