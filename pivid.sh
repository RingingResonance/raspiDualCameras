raspivid -o - \
         -t 0 \
         -n \
         -hf -vf \
         -g 15 \
         -pf high \
         -md 2 \
         -fps 15 \
         -br 55 \
         -ISO auto \
	 -rot 180 \
         -ae 32,0x00,0x8080FF \
         -a 4 \
         -a "%Y-%m-%d %X" \
         -b 10000000 \
| cvlc -vvv \
    stream:///dev/stdin \
    --no-audio \
    --demux=h264 \
    --h264-fps=15 \
    --sout '#rtp{dst=0.0.0.0,port=1234,sdp=rtsp://:9090/}'
#    --sout '#standard{access=http,mux=ts,dst=:9090}'

