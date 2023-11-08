#!/bin/bash

echo "Loop Check for Thermal Camera Capture Device. Looping 10 times."
for x in {0..10};
  do
  sleep 2
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
          cvlc v4l2:///dev/video$n \
                --sout-x264-keyint 1 \
                --sout-transcode-threads 4 \
--sout '#transcode{vcodec=h264_v4l2m2m,vb=1000,width=320,height=240,fps=10,scodec=none}:rtp{sdp=rtsp://:9091}' \
                 :demux=264
          exit 0
        else
          echo "Could not find suitable capture device for Thermal Field."
        fi
  done

exit 0
